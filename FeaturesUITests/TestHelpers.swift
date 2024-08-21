//
// TestHelpers.swift
// FeaturesUITests
//
// Created by eyalyovel on 21/08/2024.
//

import XCTest

extension XCUIElement {
  func setText(_ text: String, doubleTap: Bool = false) {
    guard let stringValue = self.value as? String else { return }
    self.tap() // Initial tap to enable typing on the field.
    if doubleTap { // The double tap assists with highlighting the text on field for deletion
      self.doubleTap()
    }
     
    if stringValue.isEmpty || stringValue == self.placeholderValue {
      self.typeText(text)
      return // Speeds up function by not going through the rest if not needed
    }
    let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)
    self.typeText(deleteString)
    guard let updatedValue = self.value as? String else { return }
    if updatedValue.isEmpty || updatedValue == self.placeholderValue {
      self.typeText(text)
    } else {
      // Seems as a customem func but I will send a text to empty field
   //   self.tapAtRelativeCoordinates(rx: 0.9, ry: 0.9)
      self.typeText(deleteString + text)
    }
  }
}
