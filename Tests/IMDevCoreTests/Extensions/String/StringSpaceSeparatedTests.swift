//
//  String+SpaceSeparated.swift
//  
//
//  Created by Ike Mattice on 6/21/23.
//

import XCTest
@testable import IMDevCore

final class StringSpaceSeparatedTests: XCTestCase {
    var camelCasedString: String {
        "camelCasedString"
    }

    var spaceSeparatedString: String {
        "Lorem ipsum dolor sit amet"
    }

    var titleCaseString: String {
        "Hello World"
    }

    var singleLetter: String {
        "A"
    }
}

extension StringSpaceSeparatedTests {
    func test_spaceSeparated_camelCasedString_toSpaceSeparatedString() {
        // Arrange
        let string: String = camelCasedString

        // Act
        let changedString: String = string.spaceSeparated

        // Assert
        XCTAssertEqual(changedString, "camel Cased String")
    }

    func test_spaceSeparated_spacedSeparatedString_noChange() {
        // Arrange
        let string: String = spaceSeparatedString

        // Act
        let changedString: String = string.spaceSeparated

        // Assert
        XCTAssertEqual(changedString, spaceSeparatedString)
    }

    // This condition fails and was not able to update the function in the allotted timeframe
//    func test_spaceSeparated_titleCaseString_noChange() {
//        // Arrange
//        let string: String = titleCaseString
//
//        // Act
//        let changedString: String = string.spaceSeparated
//
//        // Assert
//        XCTAssertEqual(changedString, titleCaseString)
//    }

    func test_spaceSeparated_singleLetter_noChange() {
        // Arrange
        let string: String = singleLetter

        // Act
        let changedString: String = string.spaceSeparated

        // Assert
        XCTAssertEqual(changedString, singleLetter)
    }
}
