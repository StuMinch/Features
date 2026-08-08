import XCTest

final class ApplePayScreen {
    static let shared = ApplePayScreen()

    private let app = XCUIApplication()

    private init() {}

    var buyButton: XCUIElement { app.buttons["applePay.buyButton"] }
    var unavailableLabel: XCUIElement { app.staticTexts["applePay.unavailableLabel"] }
}
