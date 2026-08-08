import XCTest

final class NetworkThrottlingScreen {
    static let shared = NetworkThrottlingScreen()

    private let app = XCUIApplication()

    private init() {}

    var webView: XCUIElement { app.webViews["networkThrottling.webview"] }
}
