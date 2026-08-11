# Test Spec: Text Field Screen (`TextFieldView.swift`)

## Feature Overview

The Text screen lets the user type text into a field, submit it, and see the
submitted value echoed back on screen. It is reached from the Features home
screen via the **Text** row (accessibility identifier `Text`), and can be
dismissed with a **Back** button.

## Elements Under Test

| Element | Accessibility Identifier | Behavior |
|---|---|---|
| Text input field | `text.inputField` | Placeholder "Enter your text here"; accepts free-form text |
| Submit button | `text.submitButton` | Copies the current input into the submitted-value label |
| Submitted value label | `text.submittedValueLabel` | Hidden until a non-empty value is submitted; shows "Submitted: \<value\>" |
| Back button | `text.backButton` | Dismisses the screen and returns to the home screen |

## Test Cases

### TC-1: Navigate to the Text screen
**Intent:** Verify the screen is reachable and in its initial state.
- Launch the app and tap the **Text** row on the home screen.
- Assert `text.inputField`, `text.submitButton`, and `text.backButton` exist.
- Assert `text.submittedValueLabel` does **not** exist (nothing submitted yet).

### TC-2: Submit entered text
**Intent:** Verify the core submit flow echoes the typed value.
- Tap `text.inputField` and type a known string (e.g. "Hello Sauce").
- Tap `text.submitButton`.
- Assert `text.submittedValueLabel` appears with the text "Submitted: Hello Sauce".

### TC-3: Submit with empty input shows no label
**Intent:** Verify the submitted-value label stays hidden for empty input.
- Without typing anything, tap `text.submitButton`.
- Assert `text.submittedValueLabel` does not appear.

### TC-4: Resubmission updates the label
**Intent:** Verify a second submission replaces the previously displayed value.
- Type "First" and tap Submit; assert the label reads "Submitted: First".
- Clear the field, type "Second", and tap Submit.
- Assert the label reads "Submitted: Second" and no longer shows "First".

### TC-5: Submitted value persists after clearing the input
**Intent:** Verify the label reflects the last *submitted* value, not live input.
- Type "Keep me" and tap Submit.
- Clear the text field (or type different text) without tapping Submit.
- Assert the label still reads "Submitted: Keep me".

### TC-6: Special characters and long input
**Intent:** Verify the field and label handle non-trivial content.
- Type a string containing spaces, punctuation, emoji, and/or 100+ characters.
- Tap Submit.
- Assert the label appears and contains the submitted string.

### TC-7: Back button returns to home screen
**Intent:** Verify dismissal navigation.
- From the Text screen, tap `text.backButton`.
- Assert the home screen is displayed (e.g. the **Text** row is visible again).

## Notes for Implementation

- Follow the existing Page Object Model: add cases to
  `FeaturesUITests/Screens/TextFieldScreen.swift` and
  `FeaturesUITests/Tests/TextFieldScreenTests.swift`, extending `BaseUITestCase`.
- The keyboard may cover the Submit button on smaller devices; dismiss the
  keyboard or scroll if a tap fails.
