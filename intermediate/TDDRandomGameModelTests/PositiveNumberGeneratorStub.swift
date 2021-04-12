//
//  PositiveIntegerGeneratorStub.swift
//  TDDRandomGameModelTests
//
//  Created by Joshua on 2021/04/12.
//

import Foundation
import TDDRandomGameModel

final class PositiveIntegerGeneratorStub: PositiveIntegerGeneratable {
    let numbers: [Int]
    var index: Int = 0

    internal init(numbers: [Int]) {
        self.numbers = numbers
    }

    internal init(numbers: Int...) {
        self.numbers = numbers
    }

    func generateLessThanOrEqualToHundread() -> Int {
        let result = self.numbers[index]
        self.index = (self.index + 1) % numbers.count

        return result
    }
}
