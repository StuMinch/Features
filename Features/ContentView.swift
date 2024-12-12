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
                NavigationLink(destination: TextFieldView()) {
                    HStack {
                        Image(systemName: "pencil")
                        Text("Text")
                    }
                }
                
                NavigationLink(destination: AlertView()) {
                    HStack {
                        Image(systemName: "exclamationmark")
                        Text("Alerts")
                    }
                }
                
                NavigationLink(destination: ApplePayButtonView()) {
                    HStack {
                        Image(systemName: "creditcard")
                        Text("Apple Pay")
                    }
                }
                
                
                NavigationLink(destination: WebView(url: URL(string: "https://apple.com")!)) {
                    HStack {
                        Image(systemName: "link")
                        Text("Web")
                    }
                }
                
                NavigationLink(destination: MapView()) {
                    HStack {
                        Image(systemName: "map")
                        Text("Map")
                    }
                }
                
                NavigationLink(destination: APICallsView()) {
                    HStack {
                        Image(systemName: "square")
                        Text("API Calls")
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
