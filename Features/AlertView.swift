//
//  AlertView.swift
//  Features
//
//  Created by Stuart Minchington on 6/2/24.
//

import SwiftUI

struct AlertView: View {
    @State private var showingAlert = false

    var body: some View {
      NavigationView { // Wrap the view in NavigationView
        Button("Generate Alert") {
          showingAlert = true
        }
        .padding()
        .background(Color(red: 0, green: 0, blue: 0.5))
        .foregroundStyle(.white)
        .clipShape(Capsule())
        .alert(isPresented: $showingAlert, content: {
          Alert(title: Text("Alert Title"), message: Text("This is an alert message"), primaryButton: .default(Text("OK")), secondaryButton: .destructive(Text("Cancel")))
        })
        NavigationLink(destination: SecondView()) { // NavigationLink with destination view
          Text("Go to Second View")
        }
      }
    }
  }

struct SecondView: View {
  var body: some View {
    Text("This is the second view")
  }
}

#Preview {
    AlertView()
}
