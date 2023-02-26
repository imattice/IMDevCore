//
//  Loadable.swift
//
//
//  Created by Ike Mattice on 2/13/23.
//

import Foundation

/// Describes an object that can be loaded from a ``Codable`` response object
public protocol Loadable {
    /// Defines the type that models the json response object
    associatedtype Response: Codable
    /// A file that contains the json source object
    static var fileName: String { get }

    /// An initializer that maps the values from the response object to the Loadable object
    /// - Parameter response: The response object to create the object from
    init(from response: Response)

    /// A function that loads all objects into a collection
    /// - Returns: The collection of objects
    static func loadAll() -> [Self]
}

extension Loadable {
    /// A function that loads all objects into a collection
    /// - Returns: The collection of objects
    public static func loadAll() -> [Self] {
        var responses: [Response] = [ ]

        do {
            responses = try loadResponses()
        } catch {
            print("Failed to parse response")
            print(error)
        }

        return responses.map { Self(from: $0) }
    }

    /// Loads all responses from the file name
    /// - Parameter fileName: The filename where the json object is located
    /// - Returns: A collection of responses created from the json file
    public static func loadResponses() throws -> [Response] {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
            print(fileName)
            throw ParseError.fileNotFound
        }

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let decoded = try JSONDecoder().decode([Response].self, from: data)

            return decoded
        } catch {
            throw error
        }
    }
}
