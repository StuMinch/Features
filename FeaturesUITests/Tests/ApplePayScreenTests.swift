import XCTest

final class ApplePayScreenTests: BaseUITestCase {
    private let homeScreen = HomeScreen.shared
    private let applePayScreen = ApplePayScreen.shared

    func testApplePayShowsAvailableOrUnavailableState() async throws {
        XCTAssertTrue(waitForExists(homeScreen.applePayItem, message: "Apple Pay feature is not visible on home screen."))
        await homeScreen.openApplePay()

        let terminalStateVisible = applePayScreen.buyButton.waitForExistence(timeout: 4)
            || applePayScreen.unavailableLabel.waitForExistence(timeout: 4)

        XCTAssertTrue(terminalStateVisible, "Apple Pay screen did not show expected available/unavailable state.")
    }
}
