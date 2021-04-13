//
//  TDDRandomGameModelMultiPlayerModeTests.swift
//  TDDRandomGameModelTests
//
//  Created by Joshua on 2021/04/13.
//

import XCTest
@testable import TDDRandomGameModel

class TDDRandomGameModelMultiPlayerModeTests: XCTestCase {
    func testSutCorrectlyPrintsMultiPlayerGameSetupMessage() throws {
        let sut = AppModel(generator: PositiveIntegerGeneratorStub(numbers: 50))
        _ = sut.flushOutput()
        sut.processInput("2")

        let actual = sut.flushOutput()

        XCTAssertEqual(actual, "Multiplayer game" + "\n" + "Enter player names separated with commas: ")
    }
}
