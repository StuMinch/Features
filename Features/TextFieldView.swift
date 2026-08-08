import SwiftUI

struct TextFieldView: View {
    @State private var inputText = ""
    @State private var submittedText = ""
    @State private var showBanner = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                TextField("Enter your text here", text: $inputText)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .accessibilityIdentifier("text.inputField")

                Button("Submit") {
                    submittedText = inputText
                    print("Submitted text: \(inputText)")
                }
                .accessibilityIdentifier("text.submitButton")
                .padding()
                .background(Color(red: 0, green: 0, blue: 0.5))
                .foregroundStyle(.white)
                .clipShape(Capsule())

                if !submittedText.isEmpty {
                    Text("Submitted: \(submittedText)")
                        .accessibilityIdentifier("text.submittedValueLabel")
                }

                Button("Back") {
                    presentationMode.wrappedValue.dismiss()
                }
                .accessibilityIdentifier("text.backButton")
                .padding()
                .background(Color(red: 0.5, green: 0, blue: 0))
                .foregroundStyle(.white)
                .clipShape(Capsule())
            }
            .padding()
        }
    }
}

#Preview {
    TextFieldView()
}
