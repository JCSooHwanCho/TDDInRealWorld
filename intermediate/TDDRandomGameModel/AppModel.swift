import Foundation

public final class AppModel {
    private let answer: Int
    private var output: String

    public init(generator: PositiveIntegerGeneratable) {
        self.answer = generator.generateLessThanOrEqualToHundread()
        self.output = """
    1: Single player game
    2: Multiplayer game
    3: Exit
    """
        + "\n" + "Enter selection: "
    }

    public var isCompleted: Bool = false

    public func flushOutput() -> String? {
        return self.output
    }

    public func processInput(_ input: String) {
        if input == "1" {
            self.output =
     """
    Single player game
    I'm thinking of a number between 1 and 100
    """ + "\n" + "Enter your guess: "
            return
        } else if input == "3" {
            self.isCompleted = true
            return
        }

        if let guess = Int(input) {
            if guess < self.answer {
                self.output = "Your guess is too low." + "\n" + "Enter your guess: "
            } else if guess > self.answer {
                self.output = "Your guess is too high." + "\n" + "Enter your guess: "
            }
        }
    }
}
