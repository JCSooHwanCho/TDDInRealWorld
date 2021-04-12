//
//  TDDRandomGameModelTests.swift
//  TDDRandomGameModelTests
//
//  Created by Joshua on 2021/04/12.
//

import XCTest
@testable import TDDRandomGameModel

class TDDRandomGameModelTests: XCTestCase {
    func testSutIsImcompletedWhenItIsInitialized() throws {
        let sut = AppModel(generator: PositiveIntegerGeneratorStub(numbers: 50))
        let actual = sut.isCompleted
        XCTAssertFalse(actual)
    }

    func testSutCollectlyPrintsSelectModeMessage() throws {
        let sut = AppModel(generator: PositiveIntegerGeneratorStub(numbers: 50))
        let actual = sut.flushOutput()

        XCTAssertEqual(actual, "1: Single player game" + "\n" + "2: Multiplayer game" + "\n" + "3: Exit" + "\n" + "Enter selection: ")
    }

    func testSubCorrectlyExits() throws {
        let sut = AppModel(generator: PositiveIntegerGeneratorStub(numbers: 50))
        sut.processInput("3")

        let actual = sut.isCompleted

        XCTAssertTrue(actual)
    }
}
