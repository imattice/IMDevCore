//
//  String+TitleCased.swift
//  
//
//  Created by Ike Mattice on 2/20/23.
//

import Foundation

public extension String {
    /// Title-cased string is a string that has the first letter of each word capitalized
    var titleCased: String {
        self
            .replacingOccurrences(of: "([A-Z])", with: " $1", options: .regularExpression, range: self.range(of: self))
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .capitalized
    }
}
