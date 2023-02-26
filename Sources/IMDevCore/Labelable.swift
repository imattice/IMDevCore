//
//  Labelable.swift
//  
//
//  Created by Ike Mattice on 2/26/23.
//

import Foundation

/// Describes an object that can be labeled with a custom ``String``
public protocol Labelable {
    var label: String { get }
}

extension Labelable {
    public var label: String {
        String(describing: self).titleCased
    }
}
