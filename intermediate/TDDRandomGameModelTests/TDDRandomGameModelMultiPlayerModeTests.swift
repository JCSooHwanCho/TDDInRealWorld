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

    func testSutCorrectlyPromptsSecondPlayerName() {
        let testCases = [("Foo", "Bar", "Baz"),
                         ("Bar", "Baz", "Foo"),
                         ("Baz", "Foo", "Bar")]

        for (player1, player2, player3) in testCases {
            let sut = AppModel(generator: PositiveIntegerGeneratorStub(numbers: 50))
            sut.processInput("2")
            _ = sut.flushOutput()
            sut.processInput([player1, player2, player3].joined(separator: ", "))
            _ = sut.flushOutput()
            sut.processInput("10")

            let actual = sut.flushOutput()

            XCTAssertTrue(actual.hasSuffix("Enter " + player2 + "'s guess: "), actual)
        }
    }

    func testSutCorrectlyPromptsThirdPlayerName() {
        let testCases = [("Foo", "Bar", "Baz"),
                         ("Bar", "Baz", "Foo"),
                         ("Baz", "Foo", "Bar")]

        for (player1, player2, player3) in testCases {
            let sut = AppModel(generator: PositiveIntegerGeneratorStub(numbers: 50))
            sut.processInput("2")
            _ = sut.flushOutput()
            sut.processInput([player1, player2, player3].joined(separator: ", "))
            _ = sut.flushOutput()
            sut.processInput("90")
            _ = sut.flushOutput()
            sut.processInput("90")

            let actual = sut.flushOutput()

            XCTAssertTrue(actual.hasSuffix("Enter " + player3 + "'s guess: "), actual)
        }
    }

    func testSutCorrectlyRoundsPlayer() {
        let testCases = [("Foo", "Bar", "Baz"),
                         ("Bar", "Baz", "Foo"),
                         ("Baz", "Foo", "Bar")]

        for (player1, player2, player3) in testCases {
            let sut = AppModel(generator: PositiveIntegerGeneratorStub(numbers: 50))
            sut.processInput("2")
            _ = sut.flushOutput()
            sut.processInput([player1, player2, player3].joined(separator: ", "))
            _ = sut.flushOutput()
            sut.processInput("90")
            _ = sut.flushOutput()
            sut.processInput("90")
            _ = sut.flushOutput()
            sut.processInput("90")

            let actual = sut.flushOutput()

            XCTAssertTrue(actual.hasSuffix("Enter " + player1 + "'s guess: "), actual)
        }
    }

    func testSutCorrectlyPrintsTooLowMessageInMultiPlayerGame() {
        let testCase = [(50, 40, 1, "Foo"),
                        (30, 29, 2, "Bar")]

        for (answer, guess, fails, lastPlayer) in testCase {
            let sut = AppModel(generator: PositiveIntegerGeneratorStub(numbers: answer))
            sut.processInput("2")
            sut.processInput("Foo, Bar, Baz")

            for _ in 0..<(fails-1) {
                sut.processInput("\(guess)")
            }

            _ = sut.flushOutput()
            sut.processInput("\(guess)")

            let actual = sut.flushOutput()

            XCTAssertTrue(actual.hasPrefix("\(lastPlayer)'s guess is too low." + "\n"), actual)
        }
    }

    func testSutCorrectlyPrintsTooHighMessageInMultiPlayerGame() {
        let testCase = [(50, 60, 1, "Foo"),
                        (9, 81, 2, "Bar")]

        for (answer, guess, fails, lastPlayer) in testCase {
            let sut = AppModel(generator: PositiveIntegerGeneratorStub(numbers: answer))
            sut.processInput("2")
            sut.processInput("Foo, Bar, Baz")

            for _ in 0..<(fails-1) {
                sut.processInput("\(guess)")
            }

            _ = sut.flushOutput()
            sut.processInput("\(guess)")

            let actual = sut.flushOutput()

            XCTAssertTrue(actual.hasPrefix("\(lastPlayer)'s guess is too high." + "\n"), actual)
        }
    }

    func testSutCorrectlyPrintsCorrectMessageInMultiPlayerGame() {
        let testCase = [1, 10, 100]

        for answer in testCase {
            let sut = AppModel(generator: PositiveIntegerGeneratorStub(numbers: answer))
            sut.processInput("2")
            sut.processInput("Foo, Bar, Baz")
            _ = sut.flushOutput()
            let guess = answer
            sut.processInput("\(guess)")

            let actual = sut.flushOutput()

            XCTAssertTrue(actual.hasPrefix("Correct! "), actual)
        }
    }

    func testSutCorrectlyPrintsWinnerIfMultiplayerGameFinished() {
        let testCases = [(0, "Foo"),
                        (1, "Bar"),
                        (99, "Foo"),
                        (100, "Bar")]

        for (fails, winner) in testCases {
            let sut = AppModel(generator: PositiveIntegerGeneratorStub(numbers: 50))
            sut.processInput("2")
            sut.processInput("Foo, Bar, Baz")

            for _ in 0..<fails {
                sut.processInput("30")
            }

            _ = sut.flushOutput()
            sut.processInput("50")

            let actual = sut.flushOutput()

            XCTAssertTrue(actual.contains("\(winner) wins." + "\n"))
        }
    }

    func testSutPrintsSelectModeMessageIfMultiplayerGameFinished() {
        let sut = AppModel(generator: PositiveIntegerGeneratorStub(numbers: 50))

        sut.processInput("2")
        sut.processInput("Foo, Bar, Baz")
        _ = sut.flushOutput()
        sut.processInput("50")

        let actual = sut.flushOutput()

        let expected =
            """
           1: Single player game
           2: Multiplayer game
           3: Exit
           """ + "\n" + "Enter selection: "

        XCTAssertTrue(actual.hasSuffix(expected), actual)
    }

    func testSutReturnsToModeSelectionIfMultiplyerGameFinished() {
        let sut = AppModel(generator: PositiveIntegerGeneratorStub(numbers: 50))

        sut.processInput("2")
        sut.processInput("Foo, Bar, Baz'")
        sut.processInput("20")
        sut.processInput("50")
        sut.processInput("3")

        let actual = sut.isCompleted
        XCTAssertTrue(actual)
    }
}
