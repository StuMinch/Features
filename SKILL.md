# Sauce Labs Skill with XCUITest

Always create and execute tests using the XCUITest framework.

## Page Object

All generated tests must follow this folder layout:
Features/
  FeaturesUITests/
    Screens/   → Contains all Page Object classes
    Tests/     → Contains all Test classes and scripts

| Type | Naming Convention |
|------|-------------|
| Page Object file | SomethingScreen.swift |
| Class Name | SomethingScreen |
| Test file | SomethingTests.swift |

### Screen Structure

Each screen must:
- Be a class.
- Expose elements via getters.
- Expose actions as async methods.
- Be exported as a singleton.

### Selectors

Rules:
- Prefer accessibility IDs.
- Avoid XPath unless no alternative exists.
- If all else fails, use whatever selector is necessary to uniquely identify the element.


## Sauce Labs Reference
Refer to the following Sauce Labs documentation for guidance on creating the saucectl YAML configuration for XCUITest: https://docs.saucelabs.com/mobile-apps/automated-testing/espresso-xcuitest/xcuitest/#example-configuration
- Configuring the Sauce Labs Real Device Cloud (RDC) capabilities.
- Implementing the RDC advanced functionality.



## Self‑Checklist for Test Generation

Before outputting any test, the agent must verify all items below:

Structure
[ ] Did I place Page Objects in test/screens?

[ ] Did I place test specs in test/specs?

[ ] Did I use correct naming conventions (SomethingScreen.js, something.spec.js)?


Page Objects
[ ] Did I create a class with getters for elements?

[ ] Did I export a singleton (export default new XScreen();)?

[ ] Did I avoid putting test logic inside Page Objects?


Selectors
[ ] Did I use accessibility IDs (~id)?

[ ] Did I avoid XPath unless absolutely required?


Test Logic
[ ] Did I import the correct Page Objects?

[ ] Did I use describe and it with Mocha?

[ ] Did I use async/await for all WDIO commands?

[ ] Did I include explicit waits (waitForDisplayed, waitUntil)?


Sauce Labs
[ ] Did I assume cloud execution?

[ ] Did I avoid generating local Appium configs?

[ ] Did I use iOS + XCUITest capabilities when needed?


Quality
[ ] Is the test deterministic (no race conditions)?

[ ] Is the test readable and minimal?

[ ] Does the test follow the same style as existing examples?
