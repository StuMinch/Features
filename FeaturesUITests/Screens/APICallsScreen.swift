import XCTest

final class APICallsScreen {
    static let shared = APICallsScreen()

    private let app = XCUIApplication()

    private init() {}

    var sendRequestsButton: XCUIElement { app.buttons["api.sendRequestsButton"] }
    var successLabel: XCUIElement { app.staticTexts["api.successLabel"] }
    var failureLabel: XCUIElement { app.staticTexts["api.failureLabel"] }

    func startRequests() async {
        sendRequestsButton.tap()
    }

    func waitUntilRequestsComplete(timeout: TimeInterval) -> Bool {
        let predicate = NSPredicate(format: "isEnabled == true")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: sendRequestsButton)
        return XCTWaiter.wait(for: [expectation], timeout: timeout) == .completed
    }

    func parsedRequestCounts() -> (success: Int, failure: Int)? {
        guard
            let successText = successLabel.label.split(separator: ":").dropFirst().first,
            let failureText = failureLabel.label.split(separator: ":").dropFirst().first
        else {
            return nil
        }

        let successValue = successText.trimmingCharacters(in: .whitespaces).split(separator: " ").first
        let failureValue = failureText.trimmingCharacters(in: .whitespaces).split(separator: " ").first

        guard
            let successString = successValue,
            let failureString = failureValue,
            let success = Int(successString),
            let failure = Int(failureString)
        else {
            return nil
        }

        return (success, failure)
    }
}
