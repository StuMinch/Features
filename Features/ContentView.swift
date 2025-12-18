//
//  ContentView.swift
//  Features
//
//  Created by Stuart Minchington on 5/26/24.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: BiometricsView()) {
                    HStack {
                        Image(systemName: "faceid")
                        Text("Biometrics")
                    }
                }
                .accessibilityIdentifier("Biometrics")
                
                NavigationLink(destination: WebView(url: URL(string: "https://www.fast.com")!)) {
                    HStack {
                        Image(systemName: "wifi.slash")
                        Text("Network Throttling")
                    }
                }
                .accessibilityIdentifier("Network Throttling")
                
                NavigationLink(destination: APICallsView()) {
                    HStack {
                        Image(systemName: "wifi.exclamationmark")
                        Text("Network Capture")
                    }
                }
                .accessibilityIdentifier("Network Capture")
                
                NavigationLink(destination: MapView()) {
                    HStack {
                        Image(systemName: "location.fill")
                        Text("Geolocation")
                    }
                }
                .accessibilityIdentifier("Geolocation")
                
                NavigationLink(destination: CameraView()) {
                    HStack {
                        Image(systemName: "qrcode.viewfinder")
                        Text("QR Code Scanner")
                    }
                }
                .accessibilityIdentifier("QR Code Scanner")
                
                NavigationLink(destination: ApplePayButtonView()) {
                    HStack {
                        Image(systemName: "creditcard")
                        Text("Apple Pay")
                    }
                }
                .accessibilityIdentifier("Apple Pay")
                
                NavigationLink(destination: TextFieldView()) {
                    HStack {
                        Image(systemName: "pencil")
                        Text("Text")
                    }
                }
                .accessibilityIdentifier("Text")
                
                NavigationLink(destination: AlertView()) {
                    HStack {
                        Image(systemName: "exclamationmark")
                        Text("Alerts")
                    }
                }
                .accessibilityIdentifier("Alerts")
                
            }
        }
    }
}

#Preview {
    ContentView()
}
