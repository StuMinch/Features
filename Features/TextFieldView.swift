//
//  TextFieldView.swift
//  Features
//
//  Created by Stuart Minchington on 8/19/24.
//

import SwiftUI

struct TextFieldView: View {
    @State private var inputText = ""

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
        }
        .padding()
    }
}

#Preview {
    TextFieldView()
}
