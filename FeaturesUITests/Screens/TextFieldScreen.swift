import XCTest

final class TextFieldScreen {
    static let shared = TextFieldScreen()

    private let app = XCUIApplication()

    private init() {}

    var inputField: XCUIElement { app.textFields["text.inputField"] }
    var submitButton: XCUIElement { app.buttons["text.submitButton"] }
    var submittedValueLabel: XCUIElement { app.staticTexts["text.submittedValueLabel"] }

    func enterText(_ text: String) async {
        inputField.setText(text, doubleTap: false)
    }

    func submit() async {
        submitButton.tap()
    }
}
