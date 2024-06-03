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
      }
    }
  }

#Preview {
    AlertView()
}
