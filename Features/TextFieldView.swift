import SwiftUI

struct TextFieldView: View {
    @State private var inputText = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            TextField("Enter your text here", text: $inputText)
                .textFieldStyle(.roundedBorder)
                .padding()

            Button("Submit") {
                // Handle the submitted text here
                print("Submitted text: \(inputText)")
            }
            .padding()
            .background(Color(red: 0, green: 0, blue: 0.5))
            .foregroundStyle(.white)
            .clipShape(Capsule())

            Button("Back") {
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
            .background(Color(red: 0.5, green: 0, blue: 0))
            .foregroundStyle(.white)
            .clipShape(Capsule())
        }
        .padding()
    }
}

#Preview {
    TextFieldView()
}
