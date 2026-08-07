import XCTest

final class APICallsScreenTests: BaseUITestCase {
    private let homeScreen = HomeScreen.shared
    private let apiCallsScreen = APICallsScreen.shared

    func testRequestsCompleteWithExpectedTotal() async throws {
        XCTAssertTrue(waitForExists(homeScreen.networkCaptureItem, message: "Network Capture feature is not visible on home screen."))
        await homeScreen.openNetworkCapture()

        XCTAssertTrue(waitForExists(apiCallsScreen.sendRequestsButton, message: "Send requests button is missing."))
        await apiCallsScreen.startRequests()

        let completed = apiCallsScreen.waitUntilRequestsComplete(timeout: 40)
        XCTAssertTrue(completed, "Requests did not complete within timeout.")

        XCTAssertTrue(waitForExists(apiCallsScreen.successLabel, message: "Success label is missing."))
        XCTAssertTrue(waitForExists(apiCallsScreen.failureLabel, message: "Failure label is missing."))

        guard let counts = apiCallsScreen.parsedRequestCounts() else {
            XCTFail("Unable to parse success/failure counts from labels.")
            return
        }

        XCTAssertEqual(counts.success + counts.failure, 25, "Total completed requests should always be 25.")
    }
}
