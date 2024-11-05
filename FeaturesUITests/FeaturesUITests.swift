//
//  FeaturesUITests.swift
//  FeaturesUITests
//
//  Created by Stuart Minchington on 5/26/24.
//

import XCTest

final class FeaturesUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
      try super.setUpWithError()
      continueAfterFailure = false

      app = XCUIApplication()
      app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGenerateAlert() throws {
        let app = XCUIApplication()
        app.tabBars["Tab Bar"].buttons["Alerts"].tap()
        app.buttons["Generate Alert"].tap()
        app.buttons["OK"].tap()
    }
    
    func testAPICalls() throws {
        let app = XCUIApplication()
        app.tabBars["Tab Bar"].buttons["API"].tap()
        app.buttons["Send 25 GET Requests"].tap()
        
        let successLabel = app.staticTexts["Success: 25 / 25"]
        
        // Wait for up to 30 seconds until the success label appears
        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: successLabel, handler: nil)
        waitForExpectations(timeout: 30, handler: nil)
        
        // Verify the success label or other elements if necessary
        XCTAssertTrue(successLabel.exists, "The success label did not appear within the timeout period.")
    }

    

}
