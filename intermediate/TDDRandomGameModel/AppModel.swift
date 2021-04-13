import Foundation

public final class AppModel {
    private static let selectModeMessage =
        """
    1: Single player game
    2: Multiplayer game
    3: Exit
    """ + "\n" + "Enter selection: "

    public var isCompleted: Bool = false

    private let generator: PositiveIntegerGeneratable
    private var output: String
    private var isSinglePlayerMode: Bool = false
    private lazy var processor: Processor = {
        return Processor(closure: self.processModeSelection(_:))
    }()

    public init(generator: PositiveIntegerGeneratable) {
        self.generator = generator
        self.output = Self.selectModeMessage
    }

    public func flushOutput() -> String {
        return self.output
    }

    public func processInput(_ input: String) {
        self.processor = self.processor.run(input: input)
    }

    private func processModeSelection(_ input: String) -> Processor {
        if input == "1" {
            self.output =
                """
        Single player game
        I'm thinking of a number between 1 and 100
        """ + "\n" + "Enter your guess: "
            self.isSinglePlayerMode = true

            return self.getSinglePlayerGameProcessor(answer: self.generator.generateLessThanOrEqualToHundread(),
                                                     tries: 1)
        } else {
            self.isCompleted = true

            return Processor(closure: nil)
        }
    }

    private func getSinglePlayerGameProcessor(answer: Int, tries: Int) -> Processor {
        return Processor { [weak self] input in
            guard let self = self,
                  let guess = Int(input)
            else { return Processor(closure: nil) }

            if guess < answer {
                self.output = "Your guess is too low." + "\n" + "Enter your guess: "
                return self.getSinglePlayerGameProcessor(answer: answer, tries: tries + 1)
            } else if guess > answer {
                self.output = "Your guess is too high." + "\n" + "Enter your guess: "
                return self.getSinglePlayerGameProcessor(answer: answer, tries: tries + 1)
            } else {
                let guessLiteral = tries == 1 ? "guess." : "guesses."
                self.output = "Correct! \(tries) \(guessLiteral)\n" + Self.selectModeMessage
                self.isSinglePlayerMode = false

                return Processor(closure: self.processModeSelection(_:))
            }
        }
    }
}

final class Processor {
    init(closure: ((String) -> Processor)?) {
        self.closure = closure
    }

    let closure: ((String) -> Processor)?

    func run(input: String) -> Processor {
        return closure?(input) ?? Processor(closure: nil)
    }
}


