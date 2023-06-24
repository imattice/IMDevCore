//
//  UserDefaults+UserDefaultsKey.swift
//  
//
//  Created by Ike Mattice on 6/23/23.
//

import Foundation

extension UserDefaults {
    /// A convenience method that wraps ``UserDefaults.standard.set(_value:forKey:)`` method to allow direct injection of a ``UserDefaultsKey``
    /// - Parameters:
    ///   - value: The value to persist to UserDefaults
    ///   - userDefaultsKey: The key to set the value to
    public func set(_ value: Any?, forKey userDefaultsKey: some UserDefaultsKey) {
        self.set(value, forKey: userDefaultsKey.key)
    }

    /// A convenience method that wraps ``UserDefaults.standard.value(forKey:)`` method to allow direct injection of a ``UserDefaultsKey``
    /// - Parameter userDefaultsKey: The key to access the value from
    /// - Returns: The value for the associated key, if any
    public func value(forKey userDefaultsKey: some UserDefaultsKey) -> Any? {
        self.value(forKey: userDefaultsKey.key)
    }

    /// A convenience method that wraps ``UserDefaults.standard.removeObject(forKey:)`` method to allow direct injection of a ``UserDefaultsKey``
    /// - Parameter userDefaultsKey: The key to remove the value from
    public func removeObject(forKey userDefaultsKey: some UserDefaultsKey) {
        self.removeObject(forKey: userDefaultsKey.key)
    }
}
