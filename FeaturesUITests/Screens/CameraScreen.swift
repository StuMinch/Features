import XCTest

final class CameraScreen {
    static let shared = CameraScreen()

    private let app = XCUIApplication()

    private init() {}

    var instructionLabel: XCUIElement { app.staticTexts["camera.instructionLabel"] }
    var scannedTitle: XCUIElement { app.staticTexts["camera.scannedTitle"] }
    var scanAgainButton: XCUIElement { app.buttons["camera.scanAgainButton"] }
}
