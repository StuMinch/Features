import XCTest

final class TextFieldScreenTests: BaseUITestCase {
    private let homeScreen = HomeScreen.shared
    private let textFieldScreen = TextFieldScreen.shared

    func testSubmitTextShowsConfirmation() async throws {
        let valueToSubmit = "Using page objects"

        XCTAssertTrue(waitForExists(homeScreen.textItem, message: "Text feature is not visible on home screen."))
        await homeScreen.openText()

        XCTAssertTrue(waitForExists(textFieldScreen.inputField, message: "Text input field was not found."))
        await textFieldScreen.enterText(valueToSubmit)
        await textFieldScreen.submit()

        XCTAssertTrue(waitForExists(textFieldScreen.submittedValueLabel, timeout: 3, message: "Submitted value label did not appear."))
        XCTAssertEqual(textFieldScreen.submittedValueLabel.label, "Submitted: \(valueToSubmit)")
    }
}
