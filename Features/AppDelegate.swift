import SwiftUI
import Backtrace

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        let backtraceCredentials = BacktraceCredentials(submissionUrl: URL(string: "https://submit.backtrace.io/{subdomain-name}/{submission-token}/plcrash")!)
        
        // Initialize the client
        BacktraceClient.shared = try? BacktraceClient(credentials: backtraceCredentials)
        
        return true
    }
}

@main
struct YourApp: App {
    // This connects the AppDelegate to your SwiftUI App
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}