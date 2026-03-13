//
//  BacktraceTestView.swift
//  Features
//
//  Created by Stuart Minchington on 3/12/26.
//

import SwiftUI
import Backtrace

struct BacktraceTestView: View {
    @State private var testResults: [TestResult] = []
    @State private var isRunningTests = false
    @State private var sdkStatus: String = "Checking..."
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // SDK Status Section
                VStack(alignment: .leading, spacing: 10) {
                    Text("Backtrace SDK Status")
                        .font(SauceTypography.headerFont.weight(.bold))
                        .foregroundColor(SauceColors.textPrimary)
                    
                    HStack {
                        Circle()
                            .fill(sdkStatus == "✅ Initialized" ? Color.green : Color.red)
                            .frame(width: 10, height: 10)
                        Text(sdkStatus)
                            .font(SauceTypography.bodyFont)
                            .foregroundColor(SauceColors.textSecondary)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(SauceColors.secondaryBackground)
                .cornerRadius(8)
                
                // Test Actions
                VStack(spacing: 12) {
                    Button(action: testBasicReport) {
                        HStack {
                            Image(systemName: "paperplane.fill")
                            Text("Send Test Error Report")
                                .font(SauceTypography.bodyFont.weight(.medium))
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(SauceColors.accent)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                    
                    Button(action: testWithAttributes) {
                        HStack {
                            Image(systemName: "tag.fill")
                            Text("Send Report with Attributes")
                                .font(SauceTypography.bodyFont.weight(.medium))
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(SauceColors.accent)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                    
                    Button(action: testBreadcrumbs) {
                        HStack {
                            Image(systemName: "list.bullet")
                            Text("Test Breadcrumbs")
                                .font(SauceTypography.bodyFont.weight(.medium))
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(SauceColors.accent)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                    
                    Button(action: testExceptionHandling) {
                        HStack {
                            Image(systemName: "exclamationmark.triangle.fill")
                            Text("Test Exception Handling")
                                .font(SauceTypography.bodyFont.weight(.medium))
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                    
                    Button(action: testCrashSimulation) {
                        HStack {
                            Image(systemName: "xmark.octagon.fill")
                            Text("⚠️ Simulate Crash (Will Restart App)")
                                .font(SauceTypography.bodyFont.weight(.medium))
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                }
                .padding(.horizontal)
                
                // Test Results
                if !testResults.isEmpty {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Test Results")
                            .font(SauceTypography.headerFont.weight(.bold))
                            .foregroundColor(SauceColors.textPrimary)
                        
                        ForEach(testResults) { result in
                            HStack(alignment: .top, spacing: 10) {
                                Image(systemName: result.success ? "checkmark.circle.fill" : "xmark.circle.fill")
                                    .foregroundColor(result.success ? .green : .red)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(result.testName)
                                        .font(SauceTypography.bodyFont.weight(.medium))
                                        .foregroundColor(SauceColors.textPrimary)
                                    Text(result.message)
                                        .font(SauceTypography.captionFont)
                                        .foregroundColor(SauceColors.textSecondary)
                                    Text(result.timestamp, style: .time)
                                        .font(SauceTypography.captionFont)
                                        .foregroundColor(SauceColors.textSecondary.opacity(0.7))
                                }
                                
                                Spacer()
                            }
                            .padding()
                            .background(SauceColors.secondaryBackground)
                            .cornerRadius(8)
                        }
                    }
                    .padding()
                    
                    Button(action: { testResults.removeAll() }) {
                        Text("Clear Results")
                            .font(SauceTypography.bodyFont)
                            .foregroundColor(SauceColors.accent)
                    }
                }
            }
            .padding()
        }
        .background(SauceColors.background)
        .navigationTitle("Backtrace Testing")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: checkSDKStatus)
    }
    
    // MARK: - SDK Status Check
    func checkSDKStatus() {
        if BacktraceClient.shared != nil {
            sdkStatus = "✅ Initialized"
        } else {
            sdkStatus = "❌ Not Initialized"
        }
    }
    
    // MARK: - Test Functions
    func testBasicReport() {
        guard let client = BacktraceClient.shared else {
            addTestResult(testName: "Basic Report", success: false, message: "SDK not initialized")
            return
        }
        
        client.send(message: "Test error message from Backtrace SDK") { result in
            DispatchQueue.main.async {
                if result.error == nil {
                    addTestResult(testName: "Basic Report", success: true, message: "Report sent successfully")
                } else {
                    addTestResult(testName: "Basic Report", success: false, message: "Error: \(result.error?.localizedDescription ?? "Unknown")")
                }
            }
        }
    }
    
    func testWithAttributes() {
        guard let client = BacktraceClient.shared else {
            addTestResult(testName: "Report with Attributes", success: false, message: "SDK not initialized")
            return
        }
        
        // Add custom attributes for this specific report
        let originalAttributes = client.attributes
        client.attributes = originalAttributes.merging([
            "test.type": "attribute_test",
            "test.timestamp": "\(Date().timeIntervalSince1970)",
            "test.user": "test_user_123",
            "test.screen": "BacktraceTestView"
        ]) { (_, new) in new }
        
        client.send(message: "Test report with custom attributes") { result in
            DispatchQueue.main.async {
                // Restore original attributes
                client.attributes = originalAttributes
                
                if result.error == nil {
                    addTestResult(testName: "Report with Attributes", success: true, message: "Report with custom attributes sent successfully")
                } else {
                    addTestResult(testName: "Report with Attributes", success: false, message: "Error: \(result.error?.localizedDescription ?? "Unknown")")
                }
            }
        }
    }
    
    func testBreadcrumbs() {
        guard let client = BacktraceClient.shared else {
            addTestResult(testName: "Breadcrumbs", success: false, message: "SDK not initialized")
            return
        }
        
        // Add a series of breadcrumbs
        let breadcrumb1 = client.addBreadcrumb("User navigated to BacktraceTestView", type: .navigation, level: .info)
        let breadcrumb2 = client.addBreadcrumb("User clicked test button", type: .user, level: .info)
        let breadcrumb3 = client.addBreadcrumb("Test breadcrumb with custom data", attributes: ["action": "test", "source": "test_view"], type: .log, level: .debug)
        
        if breadcrumb1 && breadcrumb2 && breadcrumb3 {
            // Send a report that will include the breadcrumbs
            client.send(message: "Test report with breadcrumbs") { result in
                DispatchQueue.main.async {
                    if result.error == nil {
                        addTestResult(testName: "Breadcrumbs", success: true, message: "Report with breadcrumbs sent successfully")
                    } else {
                        addTestResult(testName: "Breadcrumbs", success: false, message: "Error: \(result.error?.localizedDescription ?? "Unknown")")
                    }
                }
            }
        } else {
            addTestResult(testName: "Breadcrumbs", success: false, message: "Failed to add breadcrumbs")
        }
    }
    
    func testExceptionHandling() {
        guard let client = BacktraceClient.shared else {
            addTestResult(testName: "Exception Handling", success: false, message: "SDK not initialized")
            return
        }
        
        // Create a test exception
        let exception = NSException(
            name: NSExceptionName("TestException"),
            reason: "This is a test exception from Backtrace SDK validation",
            userInfo: ["test_key": "test_value"]
        )
        
        client.send(exception: exception) { result in
            DispatchQueue.main.async {
                if result.error == nil {
                    addTestResult(testName: "Exception Handling", success: true, message: "Exception report sent successfully")
                } else {
                    addTestResult(testName: "Exception Handling", success: false, message: "Error: \(result.error?.localizedDescription ?? "Unknown")")
                }
            }
        }
    }
    
    func testCrashSimulation() {
        guard BacktraceClient.shared != nil else {
            addTestResult(testName: "Crash Simulation", success: false, message: "SDK not initialized")
            return
        }
        
        // Add a breadcrumb before crashing
        BacktraceClient.shared?.addBreadcrumb("About to simulate crash", type: .log, level: .warning)
        
        // Show alert before crashing
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // This will cause a crash - the report will be sent on next app launch
            fatalError("Simulated crash for Backtrace testing")
        }
    }
    
    // MARK: - Helper Functions
    func addTestResult(testName: String, success: Bool, message: String) {
        let result = TestResult(testName: testName, success: success, message: message, timestamp: Date())
        testResults.insert(result, at: 0)
    }
}

// MARK: - Test Result Model
struct TestResult: Identifiable {
    let id = UUID()
    let testName: String
    let success: Bool
    let message: String
    let timestamp: Date
}

#Preview {
    NavigationView {
        BacktraceTestView()
    }
}
