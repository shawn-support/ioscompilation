//
//  ViewController.swift
//  PKPaymentAuthorizationViewController
//
//  Created by Antonio Diggs on 10/17/18.
//  Copyright © 2018 Antonio Diggs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var applePayButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Toggle apple pay button state
        applePayButton.enabled = Stripe.deviceSupportsApplePay()
        
    } // end func

    func handleApplePayButtonTapped() {
        let merchantIdentifier = "com.lasallesoftware.AmtAnnuity"
        let paymentRequest = Stripe.paymentRequest(withMerchantIdentifier: merchantIdentifier, country: "US", currency: "USD")
        
        // Configure the line items on the payment request
        paymentRequest.paymentSummaryItems = [
            PKPaymentSummaryItem(label: "Amount of Annuity", amount: 29.99),
            // The final line should represent your company;
            // it'll be prepended with the word "Pay" (i.e. "Pay iHats, Inc $50")
            PKPaymentSummaryItem(label: "La Salle Software, Inc", amount: 29.99),
        ]
        
        // Continued in next step
    }
    
    func handleApplePayButtonTapped() {
        let paymentRequest = ... // From previous step
        
        if Stripe.canSubmitPaymentRequest(paymentRequest) {
            // Setup payment authorization view controller
            let paymentAuthorizationViewController = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest)
            paymentAuthorizationViewController.delegate = self
            
            // Present payment authorization view controller
            present(paymentAuthorizationViewController, animated: true)
        }
        else {
            // There is a problem with your Apple Pay configuration
        }
    }
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, completion: @escaping (PKPaymentAuthorizationStatus) -> Void) {
        STPAPIClient.shared().createToken(with: payment) { (token: STPToken?, error: Error?) in
            guard let token = token, error == nil else {
                // Present error to user...
                return
            }
            
            submitTokenToBackend(token, completion: { (error: Error?) in
                if let error = error {
                    // Present error to user...
                    
                    // Notify payment authorization view controller
                    completion(.failure)
                }
                else {
                    // Save payment success
                    paymentSucceeded = true
                    
                    // Notify payment authorization view controller
                    completion(.success)
                }
            })
        }
    }
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        // Dismiss payment authorization view controller
        dismiss(animated: true, completion: {
            if (paymentSucceeded) {
                // Show a receipt page...
            }
        })
    }
    
} // end class

