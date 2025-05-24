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
                NavigationLink(destination: MapView()) {
                    HStack {
                        Image(systemName: "map")
                        Text("Map")
                    }
                }
                .accessibilityIdentifier("Map")
                
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
                
                NavigationLink(destination: ApplePayButtonView()) {
                    HStack {
                        Image(systemName: "creditcard")
                        Text("Apple Pay")
                    }
                }
                .accessibilityIdentifier("Apple Pay")
                
                
                NavigationLink(destination: WebView(url: URL(string: "https://www.fast.com")!)) {
                    HStack {
                        Image(systemName: "link")
                        Text("Web")
                    }
                }
                .accessibilityIdentifier("Web")
                
                NavigationLink(destination: APICallsView()) {
                    HStack {
                        Image(systemName: "square")
                        Text("API Calls")
                    }
                }
                .accessibilityIdentifier("API Calls")
            }
        }
    }
}

#Preview {
    ContentView()
}
