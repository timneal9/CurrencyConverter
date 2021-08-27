//
//  PurchasePremiumViewController.swift
//  CurrencyConverter
//
//  Created by Tim Neal on 8/1/21.
//  Copyright © 2021 Tim Neal. All rights reserved.
//

import UIKit
import StoreKit
import Network

class PurchasePremiumViewController: UIViewController {
    
    let productID = Constants.premiumProductID
    let monitor = NWPathMonitor()
    var internetConnected = false
    
    @IBOutlet weak var buyPremiumButton: UIButton!
    @IBOutlet weak var restorePurchasesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SKPaymentQueue.default().add(self)
        startNetworkMonitoring()
        buyPremiumButton.layer.cornerRadius = 16
        restorePurchasesButton.layer.cornerRadius = 16
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        stopNetworkMonitoring()
    }
    
    func returnToRootViewController() {
        navigationController?.popViewController(animated: true)
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
        } else {
            displayAlert(title: Constants.noInternetAlertTitle, message: Constants.noInternetAlertPurchaseMessage)
        }
    }
    
    @IBAction func restoreButtonTapped(_ sender: Any) {
        if internetConnected {
            SKPaymentQueue.default().restoreCompletedTransactions()
        } else {
            displayAlert(title: Constants.noInternetAlertTitle, message: Constants.noInternetAlertRestorePurchaseMessage)
        }
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        returnToRootViewController()
    }
}

// MARK: - SKPaymentTransactionObserver
extension PurchasePremiumViewController: SKPaymentTransactionObserver {
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
            switch transaction.transactionState {
            case .purchased:
                print("Transaction state is: Purchased")
                setPremiumUser()
                SKPaymentQueue.default().finishTransaction(transaction)
                returnToRootViewController()
            case .failed:
                print("Transaction state is: Failed")
                if let error = transaction.error {
                    let errorDescription = error.localizedDescription
                    print("Transaction failed: \(errorDescription)")
                }
                SKPaymentQueue.default().finishTransaction(transaction)
            case .restored:
                print("Transaction state is: Restored")
                setPremiumUser()
                
                SKPaymentQueue.default().finishTransaction(transaction)
                displayAlert(title: Constants.restoreSuccessfulTitle, message: Constants.restoreSuccessfulMessage)
            default:
                print("Transaction state is: \(transaction.transactionState.rawValue)")
            }
        }
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        print("Restore complete")
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        print("Restore failed with error")
        if let error = error as? SKError {
            print("IAP Restore Error:", error.localizedDescription)
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, shouldAddStorePayment
                        payment: SKPayment, for product: SKProduct) -> Bool {
        return true
    }
    
    func setPremiumUser() {
        UserDefaults.standard.set(true, forKey: Constants.premiumUserKey)
    }
    
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.okButton,
                                      style: .default,
                                      handler: { action in
                                        self.returnToRootViewController()}))
        self.present(alert, animated: true)
    }
}
