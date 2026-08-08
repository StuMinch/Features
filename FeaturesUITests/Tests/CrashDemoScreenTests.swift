import XCTest

final class CrashDemoScreenTests: BaseUITestCase {
    private let homeScreen = HomeScreen.shared
    private let crashDemoScreen = CrashDemoScreen.shared

    func testCrashDemoButtonsArePresentWithoutTriggeringCrashes() async throws {
        XCTAssertTrue(waitForExists(homeScreen.crashDemoItem, message: "Crash Demo feature is not visible on home screen."))
        await homeScreen.openCrashDemo()

        XCTAssertTrue(waitForExists(crashDemoScreen.fatalErrorButton, message: "Fatal Error button is missing."))
        XCTAssertTrue(waitForExists(crashDemoScreen.nilUnwrapButton, message: "Nil Unwrap button is missing."))
        XCTAssertTrue(waitForExists(crashDemoScreen.arrayOutOfBoundsButton, message: "Array Out of Bounds button is missing."))
        XCTAssertTrue(waitForExists(crashDemoScreen.objcExceptionButton, message: "Objective-C Exception button is missing."))
        XCTAssertTrue(waitForExists(crashDemoScreen.concurrencyViolationButton, message: "Concurrency Violation button is missing."))
    }
}
