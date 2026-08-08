import XCTest

final class WebViewScreenTests: BaseUITestCase {
    private let homeScreen = HomeScreen.shared
    private let webViewScreen = WebViewScreen.shared

    func testWebViewLoadsContainer() async throws {
        XCTAssertTrue(waitForExists(homeScreen.webViewItem, message: "WebView feature is not visible on home screen."))
        await homeScreen.openWebView()

        XCTAssertTrue(waitForExists(webViewScreen.webView, timeout: 10, message: "WebView container did not appear."))
    }
}
