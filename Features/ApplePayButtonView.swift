//
//  ApplePayButtonView.swift
//  Features
//
//  Created by Stuart Minchington on 9/16/24.
//

import SwiftUI
import PassKit

struct ApplePayButtonView: View {
    var body: some View {
        VStack {
            if PKPaymentAuthorizationController.canMakePayments(usingNetworks: [.visa, .masterCard, .amex]) {
                ApplePayButton(action: startApplePay)
                    .frame(width: 200, height: 50)
            } else {
                Text("Apple Pay is not available on this device")
            }
        }
    }
    
    func startApplePay() {
        let paymentRequest = PKPaymentRequest()
        paymentRequest.merchantIdentifier = "merchant.com.minchington.features" // Replace with your merchant ID
        paymentRequest.countryCode = "US"
        paymentRequest.currencyCode = "USD"
        paymentRequest.supportedNetworks = [.visa, .masterCard, .amex]
        paymentRequest.merchantCapabilities = .capability3DS
        
        let item = PKPaymentSummaryItem(label: "Test Item", amount: NSDecimalNumber(string: "1.00"))
        paymentRequest.paymentSummaryItems = [item]
        
        let paymentController = PKPaymentAuthorizationController(paymentRequest: paymentRequest)
        paymentController.delegate = PaymentHandler.shared
        paymentController.present { presented in
            if presented {
                print("Apple Pay presented successfully")
            } else {
                print("Failed to present Apple Pay authorization")
            }
        }
    }
}

struct ApplePayButton: UIViewRepresentable {
    var action: () -> Void
    
    func makeUIView(context: Context) -> PKPaymentButton {
        let button = PKPaymentButton(paymentButtonType: .buy, paymentButtonStyle: .black)
        button.addTarget(context.coordinator, action: #selector(Coordinator.didTapButton), for: .touchUpInside)
        return button
    }
    
    func updateUIView(_ uiView: PKPaymentButton, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(action: action)
    }
    
    class Coordinator: NSObject {
        let action: () -> Void
        
        init(action: @escaping () -> Void) {
            self.action = action
        }
        
        @objc func didTapButton() {
            action()
        }
    }
}

// MARK: - PaymentHandler (Delegate)
class PaymentHandler: NSObject, PKPaymentAuthorizationControllerDelegate {
    static let shared = PaymentHandler()

    func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        // Handle the payment
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
    }
    
    func paymentAuthorizationControllerDidFinish(_ controller: PKPaymentAuthorizationController) {
        controller.dismiss {
            print("Apple Pay finished")
        }
    }
}

#Preview {
    ApplePayButtonView()
}
