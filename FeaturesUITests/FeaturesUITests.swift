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
    
    func testTextInput() throws {
        let app = XCUIApplication()
        app.tabBars["Tab Bar"].buttons["Text"].tap()
        app.textFields["Enter your text here"].tap()
        app.textFields["Enter your text here"].typeText("Does this work on iOS 17?")
        app.buttons["Submit"].tap()
    }
    
    func testWebView() throws {
        let app = XCUIApplication()
        app.tabBars["Tab Bar"].buttons["WebView"].tap()
    }
}
