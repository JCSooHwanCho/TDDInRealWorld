import Foundation

public final class AppModel {
    let generator: PositiveIntegerGeneratable
    var output: String

    public init(generator: PositiveIntegerGeneratable) {
        self.generator = generator
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
        } else if input == "3" {
            self.isCompleted = true
        }
    }
}
