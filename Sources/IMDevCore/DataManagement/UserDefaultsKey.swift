//
//  File.swift
//  
//
//  Created by Ike Mattice on 6/23/23.
//

import Foundation

/// Describes a type that can be used as a key to access and store values in ``UserDefaults``
public protocol UserDefaultsKey: Hashable, RawRepresentable<String> {
    /// The key used to store the value to the ``UserDefaults`` store
    var key: String { get }
}

extension UserDefaultsKey {
    /// The key used to store the value to the ``UserDefaults`` store
    public var key: String {
        rawValue
    }
}
