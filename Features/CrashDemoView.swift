import SwiftUI

struct CrashDemoView: View {
    var body: some View {
        List {
            Section("Swift Crashes") {
                Button("Fatal Error Crash") {
                    CrashGenerator.triggerFatalError()
                }

                Button("Nil Unwrap Crash") {
                    CrashGenerator.triggerNilUnwrap()
                }

                Button("Array Out of Bounds Crash") {
                    CrashGenerator.triggerArrayOutOfBounds()
                }
            }

            Section("Objective‑C / Low‑Level Crashes") {
                Button("Objective‑C Exception Crash") {
                    CrashGenerator.triggerObjCException()
                }

                Button("Divide by Zero Crash") {
                    CrashGenerator.triggerDivideByZero()
                }
            }

            Section("Swift Concurrency Crash") {
                Button("Actor Isolation Violation Crash") {
                    CrashGenerator.triggerConcurrencyViolation()
                }
            }
        }
        .navigationTitle("Crash Demo")
    }
}
