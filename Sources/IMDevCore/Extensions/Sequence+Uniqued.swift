//
//  Sequence+Uniqued.swift
//  
//
//  Created by Ike Mattice on 3/5/23.
//

import Foundation

extension Sequence where Element: Hashable {
    public func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
