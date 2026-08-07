import XCTest

final class AlertScreenTests: BaseUITestCase {
    private let homeScreen = HomeScreen.shared
    private let alertScreen = AlertScreen.shared

    func testGenerateAndDismissAlert() async throws {
        XCTAssertTrue(waitForExists(homeScreen.alertsItem, message: "Alerts feature is not visible on home screen."))
        await homeScreen.openAlerts()

        XCTAssertTrue(waitForExists(alertScreen.generateAlertButton, message: "Generate Alert button was not found."))
        await alertScreen.generateAlert()

        XCTAssertTrue(waitForExists(alertScreen.alert, timeout: 3, message: "Alert did not appear."))
        XCTAssertTrue(waitForExists(alertScreen.alertOKButton, message: "OK button is missing from alert."))

        await alertScreen.dismissAlertWithOK()
        XCTAssertFalse(alertScreen.alert.exists, "Alert should be dismissed after tapping OK.")
    }
}
