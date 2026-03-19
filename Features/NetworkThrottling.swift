//
//  NetworkThrottling.swift
//  Features
//
//  Created by Stuart Minchington on 3/13/26.
//


import Foundation
import SwiftUI
import WebKit

struct NetworkThrottling: UIViewRepresentable {
    
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
