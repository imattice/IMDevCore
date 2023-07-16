//
//  String+SpaceSeparated.swift
//
//
//  Created by Ike Mattice on 6/21/23.
//

import Foundation

public extension String {
    /// Converts a camel cased string to a space separated string
    var spaceSeparated: String {
        unicodeScalars
            .dropFirst()
            .reduce(String(prefix(1))) {
                return CharacterSet.uppercaseLetters.contains($1)
                ? $0 + " " + String($1)
                : $0 + String($1)
            }
    }
}
