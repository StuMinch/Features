//
//  ContentView.swift
//  Features
//
//  Created by Stuart Minchington on 5/26/24.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    init() {
        // Customize Navigation Bar Appearance for Dark Mode
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.monospacedSystemFont(ofSize: 12, weight: .bold)]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.monospacedSystemFont(ofSize: 12, weight: .bold)]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        
        // TableView background for List
        UITableView.appearance().backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
    }

    var body: some View {
        NavigationView {
            List {
                Group {
                    NavigationLink(destination: MapView()) {
                        FeatureRow(icon: "location.fill", title: "Geolocation")
                    }
                    .accessibilityIdentifier("Geolocation")
                    
                    NavigationLink(destination: WebView(url: URL(string: "https://www.fast.com")!)) {
                        FeatureRow(icon: "wifi.exclamationmark", title: "Network Throttling")
                    }
                    .accessibilityIdentifier("Network Throttling")
                    
                    NavigationLink(destination: APICallsView()) {
                        FeatureRow(icon: "square.text.square", title: "API Calls")
                    }
                    .accessibilityIdentifier("API Calls")
                    
                    NavigationLink(destination: CameraView()) {
                        FeatureRow(icon: "qrcode.viewfinder", title: "QR Code Scanner")
                    }
                    .accessibilityIdentifier("QR Code Scanner")
                    
                    NavigationLink(destination: BiometricsView()) {
                        FeatureRow(icon: "faceid", title: "Biometrics")
                    }
                    .accessibilityIdentifier("Biometrics")
                    
                    NavigationLink(destination: ApplePayButtonView()) {
                        FeatureRow(icon: "creditcard", title: "Apple Pay")
                    }
                    .accessibilityIdentifier("Apple Pay")
                    
                    NavigationLink(destination: TextFieldView()) {
                        FeatureRow(icon: "pencil", title: "Text")
                    }
                    .accessibilityIdentifier("Text")
                    
                    NavigationLink(destination: AlertView()) {
                        FeatureRow(icon: "exclamationmark.triangle", title: "Alerts")
                    }
                    .accessibilityIdentifier("Alerts")
                }
                .listRowBackground(SauceColors.secondaryBackground)
                .listRowSeparatorTint(SauceColors.accent.opacity(0.3))
            }
            .listStyle(.plain)
            .background(SauceColors.background)
            .navigationTitle("Features")
        }
        .preferredColorScheme(.dark)
        .accentColor(SauceColors.accent)
    }
}

struct FeatureRow: View {
    let icon: String
    let title: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(SauceColors.accent)
                .frame(width: 30)
            Text(title)
                .font(SauceTypography.headerFont.weight(.medium))
                .foregroundColor(SauceColors.textPrimary)
        }
    }
}

#Preview {
    ContentView()
}
