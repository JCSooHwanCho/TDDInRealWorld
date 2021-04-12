import Foundation

import TDDRandomGameModel

public final class RandomGenerator: PositiveIntegerGeneratable {
    public func generateLessThanOrEqualToHundread() -> Int {
        return Int.random(in: 1...100)
    }
}
