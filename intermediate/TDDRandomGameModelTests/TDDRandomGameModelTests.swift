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

    func testSutCorrectlyPrintsSinglePlayerGameStartMessage() throws {
        let sut = AppModel(generator: PositiveIntegerGeneratorStub(numbers: 50))
        _ = sut.flushOutput()
        sut.processInput("1")

        let actual = sut.flushOutput()

        let expected =
     """
    Single player game
    I'm thinking of a number between 1 and 100
    """ + "\n" + "Enter your guess: "
        XCTAssertEqual(actual, expected)
    }

    func testSutCorrectlyPrintsTooLowMessageInSinglePlayerGame() throws {
        let testCases = [(50, 40), (30, 29), (89, 9)]

        for (answer, guess) in testCases {
            let sut = AppModel(generator: PositiveIntegerGeneratorStub(numbers: answer))

            sut.processInput("1")
            _ = sut.flushOutput()
            sut.processInput("\(guess)")

            let actual = sut.flushOutput()

            let expected = "Your guess is too low." + "\n" + "Enter your guess: "
            XCTAssertEqual(actual, expected)
        }
    }

    func testSutCorrectlyPrintsTooHighMessageInSinglePlayerGame() throws {
        let testCases = [(50, 60), (80, 81)]

        for (answer, guess) in testCases {
            let sut = AppModel(generator: PositiveIntegerGeneratorStub(numbers: answer))

            sut.processInput("1")
            _ = sut.flushOutput()
            sut.processInput("\(guess)")

            let actual = sut.flushOutput()

            let expected = "Your guess is too high." + "\n" + "Enter your guess: "
            XCTAssertEqual(actual, expected)
        }
    }

    func testSutCorrectlyPrintsCorrectMessageInSinglePlayerGame() throws {
        let testCases = [1, 3, 10, 100]

        for answer in testCases {
            let sut = AppModel(generator: PositiveIntegerGeneratorStub(numbers: answer))

            sut.processInput("1")
            _ = sut.flushOutput()
            let guess = answer
            sut.processInput("\(guess)")

            let actual = sut.flushOutput()

            let expected = "Correct!: "
            XCTAssertTrue(actual.hasPrefix(expected), "failed value: \(answer)")
        }
    }

    func testSutCorrectlyPrintsGuessCountIfSinglePlayerGameFinished() throws {
        let testCases = [1, 10, 100]

        for fails in testCases {
            let sut = AppModel(generator: PositiveIntegerGeneratorStub(numbers: 50))
            sut.processInput("1")

            for _ in 0..<fails {
                sut.processInput("30")
            }
            _ = sut.flushOutput()

            sut.processInput("50")

            let actual = sut.flushOutput()

            XCTAssertTrue(actual.contains("\(fails + 1) guesses.\n"), "failed value: \(fails)")
        }
    }

    func testSutCorrectlyPrintsOneGuessIfSinglePlayerGameFinished() {
        let sut = AppModel(generator: PositiveIntegerGeneratorStub(numbers: 50))
        sut.processInput("1")
        _ = sut.flushOutput()
        sut.processInput("50")

        let actual = sut.flushOutput()

        XCTAssertTrue(actual.contains("1 guess."), actual)
    }

    func testSutPrintsSelectModeMessageIfSinglePlayerGameFinished() throws {
        let sut = AppModel(generator: PositiveIntegerGeneratorStub(numbers: 50))
        sut.processInput("1")
        _ = sut.flushOutput()
        sut.processInput("50")

        let actual = sut.flushOutput()

        let expected =
     """
    1: Single player game
    2: Multiplayer game
    3: Exit
    """ + "\n" + "Enter selection: " // Xcode가 trailing whitespace를 자동으로 없애기 때문에 이 라인은 별도로 설정
        XCTAssertTrue(actual.hasSuffix(expected), actual)
    }

    func testSutReturnsToModeSelectionIfSinglePlayerGameFinished() throws {
        let sut = AppModel(generator: PositiveIntegerGeneratorStub(numbers: 50))
        sut.processInput("1")
        sut.processInput("50")
        sut.processInput("3")

        let actual = sut.isCompleted

        XCTAssertTrue(actual)
    }
}
