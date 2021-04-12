import Foundation

public final class AppModel {
    private let answer: Int
    private var output: String
    public var isCompleted: Bool = false
    private var isSinglePlayerMode: Bool = false
    private var tries: Int = 0
    public init(generator: PositiveIntegerGeneratable) {
        self.answer = generator.generateLessThanOrEqualToHundread()
        self.output = """
    1: Single player game
    2: Multiplayer game
    3: Exit
    """
        + "\n" + "Enter selection: "
    }

    public func flushOutput() -> String {
        return self.output
    }

    public func processInput(_ input: String) {
        if self.isSinglePlayerMode {
            processSinglePlayerGame(input)
        } else {
            processModeSelection(input)
        }
    }

    private func processModeSelection(_ input: String) {
        if input == "1" {
            self.output =
                """
        Single player game
        I'm thinking of a number between 1 and 100
        """ + "\n" + "Enter your guess: "
            self.isSinglePlayerMode = true
            return
        } else {
            self.isCompleted = true
            return
        }
    }


    private func processSinglePlayerGame(_ input: String) {
        self.tries += 1

        if let guess = Int(input) {
            if guess < self.answer {
                self.output = "Your guess is too low." + "\n" + "Enter your guess: "
            } else if guess > self.answer {
                self.output = "Your guess is too high." + "\n" + "Enter your guess: "
            } else {
                self.output = "Correct!: \(self.tries) guesses.\n"
            }
        }
    }
}
