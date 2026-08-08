import XCTest

final class CameraScreenTests: BaseUITestCase {
    private let homeScreen = HomeScreen.shared
    private let cameraScreen = CameraScreen.shared

    func testCameraScreenShowsInstruction() async throws {
        XCTAssertTrue(waitForExists(homeScreen.qrCodeScannerItem, message: "QR Code Scanner feature is not visible on home screen."))
        await homeScreen.openQRCodeScanner()

        XCTAssertTrue(waitForExists(cameraScreen.instructionLabel, timeout: 8, message: "Camera instruction label did not appear."))
    }
}
