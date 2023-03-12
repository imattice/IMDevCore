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

    /// Fetches all instances of the ``NSManagedObject`` that match the predicate, and converts them into ``Self``
    /// - Parameters:
    ///   - predicate: The predicate to match
    ///   - coreDataStack: The ``CoreDataStack`` that contains the persisted ``NSManagedObject``
    /// - Returns: A collection of ``Self`` that match the predicate from the persisted ``NSManagedObject``s
    static func fetch(_ predicate: FetchPredicate, from coreDataStack: CoreDataStack) -> [Self]
}

extension RecordsRetrievable {
    public static func fetch(_ predicate: FetchPredicate, from coreDataStack: CoreDataStack) -> [Self] {
        do {
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Record.fetchRequest()
            fetchRequest.predicate = predicate.predicate

            let records: [Record]? = try coreDataStack.persistentContainer.viewContext.fetch(fetchRequest) as? [Record]

            guard let records else {
                throw PersistenceError.coreDataFetchError
            }
            let dataModels: [Self] = records.compactMap { Self(for: $0) }

            return dataModels
        } catch {
            print("Error when fetching \(String(describing: Self.self))'s with predicate \(String(describing: predicate)):/n\(error)")

            return [ ]
        }
    }

    public static func fetchAll(from coreDataStack: CoreDataStack) -> [Self] {
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
