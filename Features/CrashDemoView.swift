//
//  CrashDemoView.swift
//  Features
//
//  Created by Stuart Minchington on 3/17/26.
//


import SwiftUI

struct CrashDemoView: View {
    var body: some View {
        List {
            Section("Swift Crashes") {
                Button("Fatal Error Crash") {
                    CrashGenerator.triggerFatalError()
                }
                .accessibilityIdentifier("crash.fatalErrorButton")

                Button("Nil Unwrap Crash") {
                    CrashGenerator.triggerNilUnwrap()
                }
                .accessibilityIdentifier("crash.nilUnwrapButton")

                Button("Array Out of Bounds Crash") {
                    CrashGenerator.triggerArrayOutOfBounds()
                }
                .accessibilityIdentifier("crash.arrayOutOfBoundsButton")
            }

            Section("Objective‑C / Low‑Level Crashes") {
                Button("Objective‑C Exception Crash") {
                    CrashGenerator.triggerObjCException()
                }
                .accessibilityIdentifier("crash.objcExceptionButton")

 //               Button("Divide by Zero Crash") {
 //                   CrashGenerator.triggerDivideByZero()
 //               }
            }

            Section("Swift Concurrency Crash") {
                Button("Actor Isolation Violation Crash") {
                    CrashGenerator.triggerConcurrencyViolation()
                }
                .accessibilityIdentifier("crash.concurrencyViolationButton")
            }
        }
        .navigationTitle("Crash Demo")
    }
}
