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

    func testSutCorrectlyPrintsMultiplayerGameStartMessage() {
        let sut = AppModel(generator: PositiveIntegerGeneratorStub(numbers: 50))
        sut.processInput("2")
        _ = sut.flushOutput()
        sut.processInput("foo, Bar")

        let actual = sut.flushOutput()

        XCTAssertTrue(actual.hasPrefix("I'm thinking of a number between 1 and 100."), actual)
    }

    func testSutCorrectlyPromptsFirstPlayerName() {
        let testCases = [("Foo", "Bar", "Baz"),
                         ("Bar", "Baz", "Foo"),
                         ("Baz", "Foo", "Bar")]

        for (player1, player2, player3) in testCases {
            let sut = AppModel(generator: PositiveIntegerGeneratorStub(numbers: 50))
            sut.processInput("2")
            _ = sut.flushOutput()
            sut.processInput([player1, player2, player3].joined(separator: ", "))

            let actual = sut.flushOutput()

            XCTAssertTrue(actual.hasSuffix("Enter " + player1 + "'s guess: "), actual)
        }
    }
}
