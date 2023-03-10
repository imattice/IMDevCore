//
//  Loadable.swift
//
//
//  Created by Ike Mattice on 2/13/23.
//

import Foundation

/// Describes an ``Codable`` object that can be loaded from a local file
public protocol Loadable: Codable {
    /// A file that contains the json source object
    static var fileName: String { get }
}

extension Loadable {
    /// Loads all responses from the file name
    /// - Parameter fileName: The filename where the json object is located
    /// - Returns: A collection of responses created from the json file
    public static func loadAll() throws -> [Self] {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
            print(fileName)
            throw ParseError.fileNotFound
        }

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let decoded = try JSONDecoder().decode([Self].self, from: data)

            return decoded
        } catch {
            throw error
        }
    }
}
