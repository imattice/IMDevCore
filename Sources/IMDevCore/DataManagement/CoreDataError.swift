//
//  CoreDataError.swift
//  
//
//  Created by Ike Mattice on 3/10/23.
//

/// A set of errors that can occur when working with persisting data
enum PersistenceError: Error {
    /// A case where an error has occurred while fetching objects from a ``CoreDataStack``
    case coreDataFetchError
}
