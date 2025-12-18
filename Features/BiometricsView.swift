//
//  BiometricsView.swift
//  Features
//
//  Created by Stuart Minchington on 5/1/25.
//

import SwiftUI
import LocalAuthentication

struct BiometricsView: View {
    @State private var isUnlocked = false
    @State private var authError: String? = nil

    var body: some View {
        VStack(spacing: 20) {
            if isUnlocked {
                Image(systemName: "lock.open.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.green)
                Text("Authenticated Successfully!")
                    .font(.title)
                    .foregroundColor(.green)
                
                Button("Lock") {
                    withAnimation {
                        isUnlocked = false
                    }
                }
                .buttonStyle(.bordered)
            } else {
                Image(systemName: "lock.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.red)
                Text("Locked")
                    .font(.title)
                    .foregroundColor(.red)
                
                Button(action: authenticate) {
                    Label("Authenticate", systemImage: "faceid")
                }
                .buttonStyle(.borderedProminent)
            }
            
            if let error = authError {
                Text(error)
                    .foregroundColor(.red)
                    .padding()
                    .multilineTextAlignment(.center)
            }
        }
        .padding()
        .navigationTitle("Biometrics")
    }

    func authenticate() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate to unlock features"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                        self.authError = nil
                    } else {
                        self.isUnlocked = false
                        self.authError = authenticationError?.localizedDescription ?? "Authentication failed"
                    }
                }
            }
        } else {
            // Fallback for simulator or no biometrics
            self.authError = "Biometrics not available on this device."
        }
    }
}

#Preview {
    BiometricsView()
}
