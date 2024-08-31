//
//  ContentView.swift
//  Features
//
//  Created by Stuart Minchington on 5/26/24.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            AlertView()
                .tabItem {
                    Image(systemName: "triangle")
                    Text("Alerts")
            }
            TextFieldView()
                .tabItem {
                    Image(systemName: "pencil")
                    Text("Text")
                }
            WebView(url: URL(string: "https://apple.com")!)
                .tabItem {
                    Image(systemName: "globe")
                    Text("WebView")
            }
            ApplePayView()
                .tabItem {
                    Image(systemName: "dollar")
                    Text("Apple Pay")
            }
        }
    }
}

#Preview {
    ContentView()
}
