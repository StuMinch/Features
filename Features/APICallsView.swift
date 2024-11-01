//
//  APICallsView.swift
//  Features
//
//  Created by Stuart Minchington on 11/1/24.
//

import SwiftUI
import Combine

struct APICallsView: View {
    @State private var successCount = 0
    @State private var failureCount = 0
    @State private var isRequesting = false
    private let url = URL(string: "https://httpbin.org/get")!
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Request Status")
                .font(.headline)
            
            Text("Success: \(successCount) / 25")
            Text("Failures: \(failureCount) / 25")
            
            Button(action: {
                sendRequests()
            }) {
                Text("Send 25 GET Requests")
                    .padding()
                    .background(isRequesting ? Color.gray : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(isRequesting)
        }
        .padding()
    }
    
    private func sendRequests() {
        successCount = 0
        failureCount = 0
        isRequesting = true
        
        let group = DispatchGroup()
        
        for _ in 1...25 {
            group.enter()
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    DispatchQueue.main.async {
                        successCount += 1
                    }
                } else {
                    DispatchQueue.main.async {
                        failureCount += 1
                    }
                }
                group.leave()
            }.resume()
        }
        
        group.notify(queue: .main) {
            isRequesting = false
        }
    }
}


#Preview {
    APICallsView()
}
