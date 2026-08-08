import XCTest

final class CrashDemoScreen {
    static let shared = CrashDemoScreen()

    private let app = XCUIApplication()

    private init() {}

    var fatalErrorButton: XCUIElement { app.buttons["crash.fatalErrorButton"] }
    var nilUnwrapButton: XCUIElement { app.buttons["crash.nilUnwrapButton"] }
    var arrayOutOfBoundsButton: XCUIElement { app.buttons["crash.arrayOutOfBoundsButton"] }
    var objcExceptionButton: XCUIElement { app.buttons["crash.objcExceptionButton"] }
    var concurrencyViolationButton: XCUIElement { app.buttons["crash.concurrencyViolationButton"] }
}
