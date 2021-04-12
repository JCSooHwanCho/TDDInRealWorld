//
//  TDDRandomGameModelTests.swift
//  TDDRandomGameModelTests
//
//  Created by Joshua on 2021/04/12.
//

import XCTest
@testable import TDDRandomGameModel

class TDDRandomGameModelTests: XCTestCase {
    func testSutISImcompletedWhenItIsInitialized() throws {
        let sut = AppModel(generator: PositiveIntegerGeneratorStub(numbers: 50))
        let actual = sut.isCompleted
        XCTAssertFalse(actual)
    }

}
