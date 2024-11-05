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
        TabView {
            AlertView()
                .tabItem {
                    Image(systemName: "triangle")
                    Text("Alerts")
            }
            ApplePayButtonView()
                .tabItem {
                    Image(systemName: "dollarsign.circle")
                    Text("Apple Pay")
                }
            WebView(url: URL(string: "https://apple.com")!)
                .tabItem {
                    Image(systemName: "globe")
                    Text("WebView")
            }
            MapView()
                .tabItem {
                    Image(systemName: "map")
                    Text("Map")
            }
            APICallsView()
                .tabItem {
                    Image(systemName: "25.square")
                    Text("API")
            }
        }
    }
}

#Preview {
    ContentView()
}
