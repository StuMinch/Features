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
    var biometricsItem: XCUIElement { featureItem("Biometrics") }
    var qrCodeScannerItem: XCUIElement { featureItem("QR Code Scanner") }
    var geolocationItem: XCUIElement { featureItem("Geolocation") }
    var crashDemoItem: XCUIElement { featureItem("CrashDemoView") }
    var applePayItem: XCUIElement { featureItem("Apple Pay") }
    var webViewItem: XCUIElement { featureItem("WebView") }
    var networkThrottlingItem: XCUIElement { featureItem("Network Throttling") }

    func openAlerts() async {
        alertsItem.tap()
    }

    func openText() async {
        textItem.tap()
    }

    func openNetworkCapture() async {
        networkCaptureItem.tap()
    }

    func openBiometrics() async {
        biometricsItem.tap()
    }

    func openQRCodeScanner() async {
        qrCodeScannerItem.tap()
    }

    func openGeolocation() async {
        geolocationItem.tap()
    }

    func openCrashDemo() async {
        crashDemoItem.tap()
    }

    func openApplePay() async {
        applePayItem.tap()
    }

    func openWebView() async {
        webViewItem.tap()
    }

    func openNetworkThrottling() async {
        networkThrottlingItem.tap()
    }
}
