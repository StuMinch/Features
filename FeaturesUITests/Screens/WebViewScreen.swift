import XCTest

final class WebViewScreen {
    static let shared = WebViewScreen()

    private let app = XCUIApplication()

    private init() {}

    var webView: XCUIElement { app.webViews["webview.main"] }
}
