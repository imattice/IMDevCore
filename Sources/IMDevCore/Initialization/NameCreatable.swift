//
//  NameCreatable.swift
//  
//
//  Created by Ike Mattice on 2/25/23.
//

import Foundation

/// Describes an object that can be created from a name
public protocol NameCreatable {
    /// The name associated with the object
    var name: String { get }

    /// Creates a new object from the given name
    /// - Parameter name: The name associated with the object
    init(for name: String)
}

extension NameCreatable where Self: Loadable {
    /// Creates a new object by searching through a collection of loaded, filtered objects
    /// - Parameter name: The name associated with the object
    ///
    /// Creates a ``fatalError`` if the object is not found in the loaded collection
    public init(for name: String) {
        guard let model: Self = Self.loadAll().first(where: { $0.name == name }) else {
            fatalError("\(name) does not exist in all loaded \(String(describing: Self.self))'s")
        }

        self = model
    }
}
