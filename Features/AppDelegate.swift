//
//  AppDelegate.swift
//  Features
//
//  Created by Stuart Minchington on 1/28/26.
//


import SwiftUI
import Backtrace
import CrashReporter

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        let urlString = Bundle.main.object(forInfoDictionaryKey: "BacktraceURL") as? String ?? ""
        let backtraceCredentials = BacktraceCredentials(submissionUrl: URL(string: urlString)!)
        
        // Database Settings (Handles offline storage and retries)
        let dbSettings = BacktraceDatabaseSettings()
        dbSettings.maxRecordCount = 100
        dbSettings.retryLimit = 3
        
        // Client Configuration
        // oomMode: .full enables Out-of-Memory crash detection
        _ = BacktraceClientConfiguration(
            credentials: backtraceCredentials,
            dbSettings: dbSettings,
            reportsPerMin: 10,
            allowsAttachingDebugger: true,
            oomMode: .full
        )
        
        // PLCrashReporter Customization
        // Using .BSD signal handlers is the default for Apple platforms
        // This creates an Optional (PLCrashReporterConfig?)
        let optionalConfig = PLCrashReporterConfig(
            signalHandlerType: .BSD,
            symbolicationStrategy: .all
        )

        guard let plCrashConfig = optionalConfig else {
            print("Could not create PLCrashReporterConfig")
            return true
        }

        _ = BacktraceCrashReporter(config: plCrashConfig)
        
        // Initialize the client
        BacktraceClient.shared = try? BacktraceClient(credentials: backtraceCredentials)
                
        return true
    }
}
