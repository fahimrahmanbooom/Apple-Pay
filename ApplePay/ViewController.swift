//
//  ViewController.swift
//  ApplePay
//
//  Created by Fahim Rahman on 3/6/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit
import PassKit

class ViewController: UIViewController {
    
    @IBOutlet weak var payButton: UIButton!
    
    let amountToPay = 2599.00
    let itemName = "MacBook Pro"
    
    private var payment: PKPaymentRequest = PKPaymentRequest()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        payment.merchantIdentifier = "merchant.com.fahimrahman.applePayFahim"
        payment.supportedNetworks = [.masterCard, .visa,]
        payment.supportedCountries = ["US"]
        payment.merchantCapabilities = .capability3DS
        payment.countryCode = "US"
        payment.currencyCode = "USD"

    }

    
    @IBAction func payButtonAction(_ sender: UIButton) {
        
        payment.paymentSummaryItems = [PKPaymentSummaryItem(label: itemName, amount: NSDecimalNumber(value: amountToPay))]
        
        let controller = PKPaymentAuthorizationViewController(paymentRequest: payment)
        
        if controller != nil {
            controller?.delegate = self
            DispatchQueue.main.async {
                self.present(controller!, animated: true) {
                    print("Completed")
                }
            }
        }
    }
}



extension ViewController: PKPaymentAuthorizationViewControllerDelegate {
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
    }
}
