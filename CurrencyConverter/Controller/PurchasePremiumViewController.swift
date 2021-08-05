//
//  PurchasePremiumViewController.swift
//  CurrencyConverter
//
//  Created by Tim Neal on 8/1/21.
//  Copyright © 2021 Tim Neal. All rights reserved.
//

import Foundation
import UIKit
import StoreKit

class PurchasePremiumViewController: UIViewController, SKPaymentTransactionObserver {
    
    let productID = "me.timneal.CurrencyConverter"
    
    @IBOutlet weak var buyPremiumButton: UIButton!
    @IBOutlet weak var restorePurchasesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SKPaymentQueue.default().add(self)

        if isPremiumUser() {
            setPremiumUser()
        }
        
        buyPremiumButton.layer.cornerRadius = 16
        restorePurchasesButton.layer.cornerRadius = 16
        
    }
    
    func returnToRootViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    func buyPremiumUser() {
        if SKPaymentQueue.canMakePayments() {

            let paymentRequest = SKMutablePayment()
            paymentRequest.productIdentifier = productID
            SKPaymentQueue.default().add(paymentRequest)

        } else {
            print("User can't make payments")
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {

        for transaction in transactions {
            if transaction.transactionState == .purchased {
                
                print("Transaction successful")
                setPremiumUser()
                SKPaymentQueue.default().finishTransaction(transaction)
                
            } else if transaction.transactionState == .failed {
                
                if let error = transaction.error {
                    let errorDescription = error.localizedDescription
                    print("Transaction failed: \(errorDescription)")
                }

                SKPaymentQueue.default().finishTransaction(transaction)

            } else if transaction.transactionState == .restored {
                
                setPremiumUser()
                print("Transaction restored")
                SKPaymentQueue.default().finishTransaction(transaction)
            }
        }
    }

    func setPremiumUser() {
//        UserDefaults.standard.set(true, forKey: productID)
        UserDefaults.standard.set(true, forKey: "premiumUser") // remove once productID is setup
    }

    func isPremiumUser() -> Bool {
//        let purchaseStatus = UserDefaults.standard.bool(forKey: productID)
        let purchaseStatus = UserDefaults.standard.bool(forKey: "premiumUser") // remove once productID is setup
        return purchaseStatus
    }
    
    @IBAction func buyPremiumButtonTapped(_ sender: Any) {
        buyPremiumUser()
        returnToRootViewController()
    }
    @IBAction func restoreButtonTapped(_ sender: Any) {
        SKPaymentQueue.default().restoreCompletedTransactions()
        returnToRootViewController()
    }
    @IBAction func closeButtonTapped(_ sender: Any) {
        returnToRootViewController()
    }
}
