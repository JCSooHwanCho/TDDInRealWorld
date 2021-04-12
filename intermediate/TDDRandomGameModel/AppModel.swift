import Foundation

public final class AppModel {
    public init(generator: PositiveIntegerGeneratable) {

    }

    public var isCompleted: Bool = false

    public func flushOutput() -> String? {
        return "1: Single player game" + "\n" + "2: Multiplayer game" + "\n" + "3: Exit" + "\n" + "Enter selection: "
    }

    public func processInput(_ input: String) {
        if input == "3" {
            self.isCompleted = true
        }
    }
}
