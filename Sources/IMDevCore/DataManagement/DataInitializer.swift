//
//  DataInitializer.swift
//  
//
//  Created by Ike Mattice on 3/9/23.
//

import Foundation

/// An object used to load data into Core Data
public class DataInitializer {
    private static let databaseInitializationKey: String = "hasInitializedDatabase"

    /// Indicates if the data has already been initialized
    static public var hasInitializedData: Bool {
        UserDefaults.standard.bool(forKey: databaseInitializationKey)
    }

    /// Creates a new ``DataInitializer``
    public init() { /* Empty public initializer */ }

    /// Runs the finalization methods after initialization has completed
    public func completeInitialization() {
        UserDefaults.standard.setValue(true, forKey: DataInitializer.databaseInitializationKey)
    }

    /// Destroys the current store and replaces it with a  new store, effectively wiping all data from the persistent stores
    /// - Parameter dataStack: The data stack to clear
    public func clearData(from dataStack: CoreDataStack) {
        do {
            guard let url = dataStack.persistentContainer.persistentStoreDescriptions.first?.url else { return }
            try dataStack.persistentContainer.persistentStoreCoordinator.destroyPersistentStore(at: url, type: .sqlite)
            _ = try dataStack.persistentContainer.persistentStoreCoordinator.addPersistentStore(type: .sqlite, at: url)

        } catch {
            print(error)
        }
    }
}
