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

        let expected =
     """
    1: Single player game
    2: Multiplayer game
    3: Exit
    """ + "\n" + "Enter selection: " // Xcode가 trailing whitespace를 자동으로 없애기 때문에 이 라인은 별도로 설정
        XCTAssertEqual(actual, expected)
    }

    func testSubCorrectlyExits() throws {
        let sut = AppModel(generator: PositiveIntegerGeneratorStub(numbers: 50))
        sut.processInput("3")

        let actual = sut.isCompleted

        XCTAssertTrue(actual)
    }
}
