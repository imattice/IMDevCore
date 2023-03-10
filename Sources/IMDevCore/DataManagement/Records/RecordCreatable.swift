//
//  RecordCreatable.swift
//  
//
//  Created by Ike Mattice on 3/10/23.
//

import CoreData

/// Describes an object that can create itself from an ``NSManagedObject``
protocol RecordCreatable {
    /// Creates a new object from the provided ``NSManagedObject``
    /// - Parameter for: The object to create a new instance of this object from
    init(for object: NSManagedObject)
}
