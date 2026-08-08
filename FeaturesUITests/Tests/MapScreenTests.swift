import XCTest

final class MapScreenTests: BaseUITestCase {
    private let homeScreen = HomeScreen.shared
    private let mapScreen = MapScreen.shared

    func testMapScreenRendersOrPermissionStateVisible() async throws {
        XCTAssertTrue(waitForExists(homeScreen.geolocationItem, message: "Geolocation feature is not visible on home screen."))
        await homeScreen.openGeolocation()

        let mapVisible = mapScreen.map.waitForExistence(timeout: 8)
        let permissionVisible = mapScreen.enableAccessButton.waitForExistence(timeout: 2)
            || mapScreen.deniedLabel.waitForExistence(timeout: 2)

        XCTAssertTrue(mapVisible || permissionVisible, "Map screen did not show map or a permission state.")
    }
}
