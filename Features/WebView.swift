//
//  WebView.swift
//  Features
//
//  Created by Stuart Minchington on 5/26/24.
//

import Foundation
import SwiftUI
import WebKit

// WebView(url: URL(string: "https://apple.com")!)

struct WebView: UIViewRepresentable {
    
    let url: URL
    
    func makeUIView(context: Context) -> some UIView {
        let webView = WKWebView()
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
