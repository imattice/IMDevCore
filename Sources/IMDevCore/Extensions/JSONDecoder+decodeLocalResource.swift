//
//  JSONDecoder+decodeLocalResource.swift
//  IMDevCore
//
//  Created by Ike Mattice on 1/4/25.
//

import Foundation

extension JSONDecoder {
    public func decodeLocalResource<T: Codable>(_ resourceName: String, in folder: String? = nil) throws -> LocalResourceResponseModel<T> {
        var path: String {
            if let folder {
                return "\(folder)/" + resourceName
            }
            
            return resourceName
        }
        
        guard let url: URL = Bundle.main.url(forResource: path, withExtension: "json") else {
            fatalError("Invalid URL for \(resourceName)")
        }

        do {
            let data: Data = try Data(contentsOf: url)

            return try JSONDecoder().decode(LocalResourceResponseModel<T>.self, from: data)
        } catch {

        }

        fatalError("Failed to decode \(resourceName)")
    }
}
