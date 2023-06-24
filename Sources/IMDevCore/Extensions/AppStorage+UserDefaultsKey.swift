//
//  AppStorage+UserDefaultsKey.swift
//
//
//  Created by Ike Mattice on 6/23/23.
//

import SwiftUI

/// Allows for the initialization of an ``@AppStorage`` wrapped property to be initialized with syntax using a ``UserDefaultsKey``
/// i.e. @AppStorage(.exampleKey) var storedValue: ExampleType
extension AppStorage {
    /// Creates an ``AppStorage`` property stored under the provided ``UserDefaultsKey``
    /// - Parameters:
    ///   - userDefaultsKey: The key to store the value under
    ///   - store: The ``UserDefaults`` store to persist the value to, with a default of ``nil``
    init(_ userDefaultsKey: some  UserDefaultsKey, store: UserDefaults? = nil) where Value == Bool? {
        self.init(userDefaultsKey.key, store: store)
    }

    /// Creates an ``AppStorage`` property stored under the provided ``UserDefaultsKey``
    /// - Parameters:
    ///   - userDefaultsKey: The key to store the value under
    ///   - store: The ``UserDefaults`` store to persist the value to, with a default of ``nil``
    init(_ userDefaultsKey: some UserDefaultsKey, store: UserDefaults? = nil) where Value == Int? {
        self.init(userDefaultsKey.key, store: store)
    }

    /// Creates an ``AppStorage`` property stored under the provided ``UserDefaultsKey``
    /// - Parameters:
    ///   - userDefaultsKey: The key to store the value under
    ///   - store: The ``UserDefaults`` store to persist the value to, with a default of ``nil``
    init(_ userDefaultsKey: some UserDefaultsKey, store: UserDefaults? = nil) where Value == Double? {
        self.init(userDefaultsKey.key, store: store)
    }

    /// Creates an ``AppStorage`` property stored under the provided ``UserDefaultsKey``
    /// - Parameters:
    ///   - userDefaultsKey: The key to store the value under
    ///   - store: The ``UserDefaults`` store to persist the value to, with a default of ``nil``
    init(_ userDefaultsKey: some UserDefaultsKey, store: UserDefaults? = nil) where Value == String? {
        self.init(userDefaultsKey.key, store: store)
    }

    /// Creates an ``AppStorage`` property stored under the provided ``UserDefaultsKey``
    /// - Parameters:
    ///   - userDefaultsKey: The key to store the value under
    ///   - store: The ``UserDefaults`` store to persist the value to, with a default of ``nil``
    init(_ userDefaultsKey: some UserDefaultsKey, store: UserDefaults? = nil) where Value == URL? {
        self.init(userDefaultsKey.key, store: store)
    }

    /// Creates an ``AppStorage`` property stored under the provided ``UserDefaultsKey``
    /// - Parameters:
    ///   - userDefaultsKey: The key to store the value under
    ///   - store: The ``UserDefaults`` store to persist the value to, with a default of ``nil``
    init(_ userDefaultsKey: some UserDefaultsKey, store: UserDefaults? = nil) where Value == Data? {
        self.init(userDefaultsKey.key, store: store)
    }

    /// Creates an ``AppStorage`` property stored under the provided ``UserDefaultsKey``
    /// - Parameters:
    ///   - userDefaultsKey: The key to store the value under
    ///   - store: The ``UserDefaults`` store to persist the value to, with a default of ``nil``
    init<R>(_ userDefaultsKey: some UserDefaultsKey, store: UserDefaults? = nil) where Value == R?, R : RawRepresentable, R.RawValue == String {
        self.init(userDefaultsKey.key, store: store)
    }
}



