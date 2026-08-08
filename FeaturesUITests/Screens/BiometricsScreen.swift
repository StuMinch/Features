import XCTest

final class BiometricsScreen {
    static let shared = BiometricsScreen()

    private let app = XCUIApplication()

    private init() {}

    var authenticateButton: XCUIElement { app.buttons["biometrics.authenticateButton"] }
    var lockedLabel: XCUIElement { app.staticTexts["biometrics.lockedLabel"] }
    var authenticatedLabel: XCUIElement { app.staticTexts["biometrics.authenticatedLabel"] }
    var errorLabel: XCUIElement { app.staticTexts["biometrics.errorLabel"] }

    func authenticate() async {
        authenticateButton.tap()
    }
}
