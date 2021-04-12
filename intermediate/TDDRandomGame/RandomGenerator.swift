import Foundation

import TDDRandomGameModel

struct RandomGenerator: PositiveIntegerGeneratable {
    public func generateLessThanOrEqualToHundread() -> Int {
        return Int.random(in: 1...100)
    }
}
