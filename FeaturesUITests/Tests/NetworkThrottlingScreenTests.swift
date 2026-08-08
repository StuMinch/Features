import XCTest

final class NetworkThrottlingScreenTests: BaseUITestCase {
    private let homeScreen = HomeScreen.shared
    private let throttlingScreen = NetworkThrottlingScreen.shared

    func testNetworkThrottlingLoadsContainer() async throws {
        XCTAssertTrue(waitForExists(homeScreen.networkThrottlingItem, message: "Network Throttling feature is not visible on home screen."))
        await homeScreen.openNetworkThrottling()

        XCTAssertTrue(waitForExists(throttlingScreen.webView, timeout: 10, message: "Network Throttling web view did not appear."))
    }
}
