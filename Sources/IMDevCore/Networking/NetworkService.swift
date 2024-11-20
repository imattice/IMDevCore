//
//  NetworkService.swift
//  IMDevCore
//
//  Created by Ike Mattice on 11/20/24.
//

import Foundation

public final class NetworkService {
    static let shared: NetworkService = NetworkService()

    func request(_ url: URL?) async -> Result<Data, NetworkError> {
        guard let url else {
            return .failure(.invalidUrl)
        }

        guard NetworkMonitor.shared.isReachable else {
            if NetworkMonitor.shared.status == .requiresConnection {
                return .failure(.networkMonitorNotConfigured)
            }

            return .failure(.networkUnavailable)
        }

        do {
            let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))

            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                return .failure(.internalServerError(code: response.statusCode))
            }

            return .success(data)

        } catch {
            return .failure(.emptyResponse)
        }
    }

    func request<ResponseModel: Codable>(_ url: URL?) async -> Result<ResponseModel, NetworkError> {
        guard let url else {
            return .failure(.invalidUrl)
        }

        let networkResult: Result<Data, NetworkError> = await request(url)

        guard case .success(let networkData) = networkResult else {
            return .failure(.emptyResponse)
        }

        do {
            let decodedModel: ResponseModel = try JSONDecoder().decode(ResponseModel.self, from: networkData)

            return .success(decodedModel)
        } catch let DecodingError.dataCorrupted(context) {
            return .failure(.jsonParseError(.dataCorrupted(description: context.debugDescription)))
        } catch let DecodingError.keyNotFound(key, context) {
            return .failure(.jsonParseError(.keyNotFound(key: key, codePath: context.codingPath, description: context.debugDescription)))
        } catch let DecodingError.valueNotFound(value, context) {
            return .failure(.jsonParseError(.valueNotFound(value: value, codePath: context.codingPath, description: context.debugDescription)))
        } catch let DecodingError.typeMismatch(type, context) {
            return .failure(.jsonParseError(.typeMismatch(type: type, codePath: context.codingPath, description: context.debugDescription)))
        } catch {
            return .failure(.jsonParseError(.unknown(description: error.localizedDescription)))
        }
    }
}
