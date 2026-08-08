import XCTest

final class MapScreen {
    static let shared = MapScreen()

    private let app = XCUIApplication()

    private init() {}

    var map: XCUIElement { app.otherElements["geo.map"] }
    var enableAccessButton: XCUIElement { app.buttons["geo.enableAccessButton"] }
    var deniedLabel: XCUIElement { app.staticTexts["geo.deniedLabel"] }
}
