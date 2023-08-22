//
//  Date+ExtensionTests.swift
//  moonpig-interviewTests
//
//  Created by Lenard Pop on 23/08/2023.
//

import Foundation
import XCTest
@testable import moonpig_interview

class DateExtensionTests: XCTestCase {

    func test_toFriendlyDate_short() {
        // Arrange
        var data = [(date: Date, expected: String)]()
        data.append((date: Date.init(year: 2023, month: 1, day: 1, hour: 0, minute: 15, second: 45), expected: "1st Jan 23"))
        data.append((date: Date.init(year: 2023, month: 12, day: 30, hour: 23, minute: 15, second: 45), expected: "30th Dec 23"))

        data.forEach { testCase in
            // Act
            let result = testCase.date.toFriendlyDateShort()

            // Assert
            XCTAssertEqual(testCase.expected, result)
        }
    }

    func test_toFriendlyDate_long() {
        // Arrange
        var data = [(date: Date, expected: String)]()
        data.append((date: Date.init(year: 2023, month: 1, day: 1, hour: 0, minute: 15, second: 45), expected: "1st Jan 2023"))
        data.append((date: Date.init(year: 2023, month: 12, day: 31, hour: 23, minute: 15, second: 45), expected: "31st Dec 2023"))

        data.forEach { testCase in
            // Act
            let result = testCase.date.toFriendlyDateLong()

            // Assert
            XCTAssertEqual(testCase.expected, result)
        }
    }
}
