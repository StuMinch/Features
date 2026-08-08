import XCTest

final class BiometricsScreenTests: BaseUITestCase {
    private let homeScreen = HomeScreen.shared
    private let biometricsScreen = BiometricsScreen.shared

    func testBiometricsFlowShowsTerminalState() async throws {
        XCTAssertTrue(waitForExists(homeScreen.biometricsItem, message: "Biometrics feature is not visible on home screen."))
        await homeScreen.openBiometrics()

        XCTAssertTrue(waitForExists(biometricsScreen.lockedLabel, message: "Biometrics locked state is missing."))
        XCTAssertTrue(waitForExists(biometricsScreen.authenticateButton, message: "Authenticate button is missing."))

        await biometricsScreen.authenticate()

        let terminalStateShown = biometricsScreen.authenticatedLabel.waitForExistence(timeout: 4)
            || biometricsScreen.errorLabel.waitForExistence(timeout: 4)
        XCTAssertTrue(terminalStateShown, "Biometrics did not produce an authenticated or error state.")
    }
}
