//
//  ParseError.swift
//  
//
//  Created by Ike Mattice on 2/25/23.
//

import Foundation

/// Options for errors that can occur from parsing methods
enum ParseError: Error {
    /// An error that occurs when the file cannot be found
    case fileNotFound
    /// An error that occurs when the type is invalid
    case invalidType
}
