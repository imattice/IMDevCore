//
//  CoreDataStack.swift
//  
//
//  Created by Ike Mattice on 3/9/23.
//

import CoreData

/// A object used to interact with ``CoreData``
public class CoreDataStack {
    /// The context that runs on the main thread
    ///
    /// Methods that are run on the main thread can block UI
    public var mainContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    /// The persistent container for CoreData
    public var persistentContainer: NSPersistentContainer

    /// Creates a new ``CoreDataStack`` for the given store file name
    /// - Parameter persistentStoreName: The file name for the core data store file
    public init(
        persistentStoreName: String
    ) {
        let container: NSPersistentContainer = NSPersistentContainer(name: persistentStoreName)
        container.loadPersistentStores { _, error in
            if let error: NSError = error as? NSError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }

        self.persistentContainer = container
    }

    /// Saves the current state of the main context
    public func saveMainContext() {
        do {
            try mainContext.save()
        } catch {
            print("Failed to save context")
        }
    }
}
