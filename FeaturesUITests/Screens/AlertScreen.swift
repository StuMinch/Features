import XCTest

final class AlertScreen {
    static let shared = AlertScreen()

    private let app = XCUIApplication()

    private init() {}

    var generateAlertButton: XCUIElement { app.buttons["alerts.generateButton"] }
    var alert: XCUIElement { app.alerts["Alert Title"] }
    var alertOKButton: XCUIElement { app.alerts["Alert Title"].buttons["OK"] }

    func generateAlert() async {
        generateAlertButton.tap()
    }

    func dismissAlertWithOK() async {
        alertOKButton.tap()
    }
}
