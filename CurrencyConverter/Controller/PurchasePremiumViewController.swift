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
import Network

class PurchasePremiumViewController: UIViewController, SKPaymentTransactionObserver {
    
    let productID = "me.timneal.CurrencyConverter"
    var internetConnected = false
    let monitor = NWPathMonitor()
    
    @IBOutlet weak var buyPremiumButton: UIButton!
    @IBOutlet weak var restorePurchasesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SKPaymentQueue.default().add(self)
        
        startNetworkMonitoring()
        
        if isPremiumUser() {
            setPremiumUser()
        }
        
        buyPremiumButton.layer.cornerRadius = 16
        restorePurchasesButton.layer.cornerRadius = 16
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        stopNetworkMonitoring()
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
    
    func startNetworkMonitoring() {
        
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                self.internetConnected = true
            }
            else {
                self.internetConnected = false
            }
        }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
    
    func stopNetworkMonitoring() {
        monitor.cancel()
    }
    
    @IBAction func buyPremiumButtonTapped(_ sender: Any) {
        if internetConnected {
            buyPremiumUser()
            returnToRootViewController()
        } else {
            let alert = UIAlertController(title: "No Internet Connection", message: "Internet connection is required to make purchases. Please connect to internet and try again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    @IBAction func restoreButtonTapped(_ sender: Any) {
        if internetConnected {
            SKPaymentQueue.default().restoreCompletedTransactions()
            returnToRootViewController()
        } else {
            let alert = UIAlertController(title: "No Internet Connection", message: "Internet connection is required to make restore purchases. Please connect to internet and try again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    @IBAction func closeButtonTapped(_ sender: Any) {
        returnToRootViewController()
    }
}
