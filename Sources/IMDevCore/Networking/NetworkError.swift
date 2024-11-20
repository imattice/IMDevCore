//
//  NetworkError.swift
//  IMDevCore
//
//  Created by Ike Mattice on 11/20/24.
//

enum NetworkError: Error {
    case invalidUrl
    case internalServerError(code: Int)
    case emptyResponse
    case networkUnavailable
    case networkMonitorNotConfigured
    case jsonParseError(_ error: JSONParseError)

    enum JSONParseError: Error {
        case dataCorrupted(description: String)
        case keyNotFound(key: any CodingKey, codePath: [any CodingKey], description: String)
        case valueNotFound(value: Any.Type, codePath: [any CodingKey], description: String)
        case typeMismatch(type: Any.Type , codePath: [any CodingKey], description: String)
        case unknown(description: String)
    }
}
