//
//  CrashGenerator.swift
//  Features
//
//  Created by Stuart Minchington on 3/17/26.
//


import Foundation

@MainActor
enum CrashGenerator {

    static func triggerFatalError() {
        fatalError("Intentional fatalError() crash for testing crash reporting")
    }

    static func triggerNilUnwrap() {
        let value: String? = nil
        _ = value!   // Boom
    }

    static func triggerArrayOutOfBounds() {
        let array = [1, 2, 3]
        _ = array[10]
    }

    static func triggerObjCException() {
        let obj: AnyObject = NSString()
        obj.perform(Selector(("nonexistentMethod")))
    }

//    static func triggerDivideByZero() {
//        let x = 1 / 0
//        print(x)
//    }

    static func triggerConcurrencyViolation() {
        actor DemoActor {
            var value = 0
        }

        let actor = DemoActor()

        Task.detached {
            // Accessing actor state from outside its isolation
            print(await actor.value)
        }
    }
}
