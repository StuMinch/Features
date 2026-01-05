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
        app.collectionViews.staticTexts["Alerts"].tap()
        app.buttons["Generate Alert"].tap()
        app.buttons["OK"].tap()
    }
    
    func testTypeText() throws {
        let app = XCUIApplication()
        app.collectionViews/*@START_MENU_TOKEN@*/.staticTexts["Text"]/*[[".cells",".buttons[\"Text\"].staticTexts[\"Text\"]",".staticTexts[\"Text\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.textFields["Enter your text here"].tap()
        app.typeText("Using standard typeText")
        app.buttons["Submit"].tap()
    }
    
    
    func testSetText() throws {
        let app = XCUIApplication()
        app.collectionViews/*@START_MENU_TOKEN@*/.staticTexts["Text"]/*[[".cells",".buttons[\"Text\"].staticTexts[\"Text\"]",".staticTexts[\"Text\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        //sleep(1)
        app.textFields["Enter your text here"].setText("Using setText", doubleTap: false)
        app.buttons["Submit"].tap()
    }


    
    func testAPICalls() throws {
        let app = XCUIApplication()
        app.collectionViews.staticTexts["Network Capture"].tap()
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
