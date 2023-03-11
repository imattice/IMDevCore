//
//  RecordsRetrievable.swift
//  
//
//  Created by Ike Mattice on 3/10/23.
//

import CoreData

/// Describes an object that can fetch all persisted objects and convert them to ``Self``
public protocol RecordsRetrievable: RecordCreatable {
    /// Fetches all instances of the ``NSManagedObject``'s that back this type, and converts them into ``Self``
    /// - Parameter coreDataStack: The ``CoreDataStack`` that contains the persisted ``NSManagedObject``
    /// - Returns: A collection of ``Self`` that are generated from the persisted ``NSManagedObject``s
    static func fetchAll(from coreDataStack: CoreDataStack) -> [Self]
}

extension RecordsRetrievable {
    static func fetchAll(from coreDataStack: CoreDataStack) -> [Self] {
        do {
            let records: [Record]? = try coreDataStack.persistentContainer.viewContext.fetch(Record.fetchRequest()) as? [Record]
            guard let records else {
                throw PersistenceError.coreDataFetchError
            }
            let dataModels: [Self] = records.compactMap { Self(for: $0) }

            return dataModels
        } catch {
            print("Error when fetching all \(String(describing: Self.self))'s:/n\(error)")

            return [ ]
        }
    }
}
