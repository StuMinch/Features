import XCTest

class BaseUITestCase: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app.launch()
    }

    @discardableResult
    func waitForExists(_ element: XCUIElement, timeout: TimeInterval = 5, message: String) -> Bool {
        let exists = element.waitForExistence(timeout: timeout)
        XCTAssertTrue(exists, message)
        return exists
    }
}
