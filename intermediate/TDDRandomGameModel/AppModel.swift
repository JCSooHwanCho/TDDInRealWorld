import Foundation

public final class AppModel {
    private static let selectModeMessage =
    """
    1: Single player game
    2: Multiplayer game
    3: Exit
    """ + "\n" + "Enter selection: "
    private let generator: PositiveIntegerGeneratable
    private var output: String
    public var isCompleted: Bool = false
    private var isSinglePlayerMode: Bool = false
    private var tries: Int = 0
    private var answer: Int = 0

    public init(generator: PositiveIntegerGeneratable) {
        self.generator = generator
        self.output = Self.selectModeMessage
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
            self.answer = self.generator.generateLessThanOrEqualToHundread()
        } else {
            self.isCompleted = true
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
                let guessLiteral = self.tries == 1 ? "guess." : "guesses."
                self.output = "Correct! \(self.tries) \(guessLiteral)\n" + Self.selectModeMessage
                self.isSinglePlayerMode = false
            }
        }
    }
}
