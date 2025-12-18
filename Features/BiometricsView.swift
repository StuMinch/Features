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
        ZStack {
            SauceColors.background.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                if isUnlocked {
                    VStack(spacing: 20) {
                        Image(systemName: "lock.open.fill")
                            .font(.system(size: 80))
                            .foregroundColor(SauceColors.accent)
                        Text("Authenticated")
                            .font(SauceTypography.headerFont)
                            .foregroundColor(SauceColors.accent)
                        
                        Text("Access Granted")
                            .font(SauceTypography.bodyFont)
                            .foregroundColor(SauceColors.textPrimary)
                    }
                    .transition(.scale)
                    
                    Button("Lock") {
                        withAnimation {
                            isUnlocked = false
                        }
                    }
                    .buttonStyle(SauceButtonStyle())
                } else {
                    VStack(spacing: 20) {
                        Image(systemName: "lock.fill")
                            .font(.system(size: 80))
                            .foregroundColor(.red)
                        Text("Locked")
                            .font(SauceTypography.headerFont)
                            .foregroundColor(.red)
                    }
                    
                    Button(action: authenticate) {
                        Label("Authenticate", systemImage: "faceid")
                    }
                    .buttonStyle(SauceButtonStyle())
                }
                
                if let error = authError {
                    Text(error)
                        .font(SauceTypography.captionFont)
                        .foregroundColor(.red)
                        .padding()
                        .multilineTextAlignment(.center)
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(8)
                }
            }
            .padding()
        }
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
                        withAnimation {
                            self.isUnlocked = true
                            self.authError = nil
                        }
                    } else {
                        self.isUnlocked = false
                        self.authError = authenticationError?.localizedDescription ?? "Authentication failed"
                    }
                }
            }
        } else {
            self.authError = "Biometrics not available on this device."
        }
    }
}

#Preview {
    BiometricsView()
}
