import Foundation
import TDDRandomGameModel

private func runMainLoop(_ model: AppModel, _ scanner: () -> String) {
    while !model.isCompleted {
        print(model.flushOutput())

        model.processInput(scanner())
    }
}

let appModel = AppModel(generator: RandomGenerator())

runMainLoop(appModel) {
    if let input = readLine() {
        return input
    } else {
        return ""
    }
}
