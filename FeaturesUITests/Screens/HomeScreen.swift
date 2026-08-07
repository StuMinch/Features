import XCTest

final class HomeScreen {
    static let shared = HomeScreen()

    private let app = XCUIApplication()

    private init() {}

    func featureItem(_ identifier: String) -> XCUIElement {
        app.descendants(matching: .any).matching(identifier: identifier).firstMatch
    }

    var alertsItem: XCUIElement { featureItem("Alerts") }
    var textItem: XCUIElement { featureItem("Text") }
    var networkCaptureItem: XCUIElement { featureItem("Network Capture") }

    func openAlerts() async {
        alertsItem.tap()
    }

    func openText() async {
        textItem.tap()
    }

    func openNetworkCapture() async {
        networkCaptureItem.tap()
    }
}
