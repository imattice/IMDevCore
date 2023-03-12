//
//  FetchPredicate.swift
//  
//
//  Created by Ike Mattice on 3/10/23.
//

import Foundation

public enum FetchPredicate {
    case name(matching: String)

    internal var predicate: NSPredicate {
        switch self {
        case .name(let name):
            return NSPredicate(format: "name LIKE %@", "\(name)")
        }
    }
}
