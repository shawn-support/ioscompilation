//
//  ViewController.swift
//  PKPaymentAuthorizationViewController
//
//  Created by Antonio Diggs on 10/17/18.
//  Copyright © 2018 Antonio Diggs. All rights reserved.
//

import UIKit
import Stripe
import AFNetworking

var paymentSucceeded: Bool = false

class ViewController: UIViewController, PKPaymentAuthorizationViewControllerDelegate {
//    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
//
//    } // end func
    
    @IBOutlet weak var applePayButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Toggle apple pay button state
        applePayButton.isEnabled = Stripe.deviceSupportsApplePay()
        
    } // end func
    
    @IBAction func handleApplePayButtonTapped(_ sender: Any) {
        
        let merchantIdentifier = "com.lasallesoftware.AmtAnnuity"
        // let paymentRequest = Stripe.paymentRequest(withMerchantIdentifier: "merchant.com.lasallesoftware.merchantapp2", country: "US", currency: "USD")
        let paymentRequest = Stripe.paymentRequest(withMerchantIdentifier: merchantIdentifier, country: "US", currency: "USD")
        
//        // Configure the line items on the payment request
//        paymentRequest.paymentSummaryItems = [
//            PKPaymentSummaryItem(label: "Amount of Annuity", amount: 29.99),
//            // The final line should represent your company;
//            // it'll be prepended with the word "Pay" (i.e. "Pay iHats, Inc $50")
//            PKPaymentSummaryItem(label: "La Salle Software, Inc", amount: 29.99),
//        ]
        
        paymentRequest.paymentSummaryItems = [
            PKPaymentSummaryItem(label: "Fancy Hat", amount: 50.00),
            // The final line should represent your company;
            // it'll be prepended with the word "Pay" (i.e. "Pay iHats, Inc $50")
            PKPaymentSummaryItem(label: "iHats, Inc", amount: 50.00),
        ]
        
        // Continued in next step
        
        // func handleApplePayButtonTapped() {
        if Stripe.canSubmitPaymentRequest(paymentRequest) {
        }
 /*       else
        {
       // do {  // end else
            // There is a problem with your Apple Pay configuration
    }
 */
    } // end ApplePayButton
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, completion: @escaping (PKPaymentAuthorizationStatus) -> Void) {
        STPAPIClient.shared().createToken(with: payment) { (token: STPToken?, error: Error?) in
            guard let token = token, error == nil else {
                // Present error to user...
                return
            }
            
//            submitTokenToBackend(token, completion: { (error: Error?) in
//                if let error = error {
//                    // Present error to user...
//
//                    // Notify payment authorization view controller
//                    completion(.failure)
//                }
//                else {
//                    // Save payment success
//                    paymentSucceeded = true
//
//                    // Notify payment authorization view controller
//                    completion(.success)
//                }
//            })
        }
    }
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        // Dismiss payment authorization view controller
        dismiss(animated: true, completion: {
            if (paymentSucceeded) {
                // Show a receipt page...
            }
        })
    } // end func
        
    func submitTokenToBackend() {
        
        // tak strip SDK token
            
    } // end func
        
} // end class

