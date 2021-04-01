//
//  RootViewController.swift
//  CurrencyConverter
//
//  Created by Tim Neal on 3/27/21.
//  Copyright © 2021 Tim Neal. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    @IBOutlet weak var baseAmountLabel: UILabel!
    @IBOutlet weak var baseCurrencyCodeLabel: UILabel!
    @IBOutlet weak var baseFlagImage: UIImageView!
    
    @IBOutlet weak var convertedAmountLabel: UILabel!
    @IBOutlet weak var convertedCurrencyCodeLabel: UILabel!
    @IBOutlet weak var convertedFlagImage: UIImageView!
    
//    let currencyExchangeManager = CurrencyExchangeManager()
    var baseAmount: String = ""
    var decimalActive: Bool = false
    var decimalString: String = ".00"
    var decimalActiveCount: Int = 0
    
    func numButtonTapped(num: String) {
        if decimalActive {
            let index = decimalString.index(decimalString.startIndex, offsetBy: 1)
            decimalString.remove(at: index)
            decimalString.append(num)
            decimalActiveCount += 1
            checkDecimalCount()
        } else {
            if baseAmount == "0" {
                baseAmount = num
            } else {
                baseAmount.append(num)
            }
        }
        updateBaseAmount()
    }
    
    func checkDecimalCount() {
        if decimalActiveCount >= 2 {
            decimalActive = false
            decimalActiveCount = 0
        }
    }
    
    func deleteNum() {
        if decimalString[decimalString.index(decimalString.endIndex, offsetBy: -1)] != "0" {
            let index = decimalString.index(decimalString.endIndex, offsetBy: -1)
            decimalString = String(decimalString[..<index]) + "0"
        } else if decimalString == ".00" {
            if baseAmount.count == 1 {
                baseAmount = "0"
            } else {
                let index = baseAmount.index(baseAmount.endIndex, offsetBy: -1)
                baseAmount = String(baseAmount[..<index])
            }
        } else {
            decimalString = ".00"
        }
        updateBaseAmount()
    }
    
    func updateBaseAmount() {
        baseAmountLabel.text = baseAmount + decimalString
        updateConvertedAmount()
    }
    
    func updateConvertedAmount() {
        let baseText = baseAmountLabel.text ?? "0.0"
        let baseTextDouble = Double(baseText) ?? 0.0
        var convertedText = String(format: "%.2f", (baseTextDouble * 2.0))
        print(convertedText)
        if convertedText.count <= 2 {
            convertedText.append("0")
        }
        convertedAmountLabel.text = convertedText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        CurrencyTableView.delegate = self
//        CurrencyTableView.dataSource = self
//        CurrencyTableView.tableFooterView = UIView()
//        currencies = createArray()
//
//        currencyExchangeManager.getExchangeRate(for: "USD")
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "HomeToChange", sender: self)
    }
    @IBAction func oneNumButtonTapped(_ sender: UIButton) {
        numButtonTapped(num: "1")
    }
    @IBAction func twoNumButtonTapped(_ sender: UIButton) {
        numButtonTapped(num: "2")
    }
    @IBAction func threeNumButtonTapped(_ sender: UIButton) {
        numButtonTapped(num: "3")
    }
    @IBAction func fourNumButtonTapped(_ sender: UIButton) {
        numButtonTapped(num: "4")
    }
    @IBAction func fiveNumButtonTapped(_ sender: UIButton) {
        numButtonTapped(num: "5")
    }
    @IBAction func sixNumButtonTapped(_ sender: UIButton) {
        numButtonTapped(num: "6")
    }
    @IBAction func sevenNumButtonTapped(_ sender: UIButton) {
        numButtonTapped(num: "7")
    }
    @IBAction func eightNumButtonTapped(_ sender: UIButton) {
        numButtonTapped(num: "8")
    }
    @IBAction func nineNumButtonTapped(_ sender: UIButton) {
        numButtonTapped(num: "9")
    }
    @IBAction func decimalNumButtonTapped(_ sender: UIButton) {
        decimalActive = true
    }
    @IBAction func zeroNumButtonTapped(_ sender: UIButton) {
        numButtonTapped(num: "0")
    }
    @IBAction func deleteNumButtonTapped(_ sender: UIButton) {
        deleteNum()
    }
}
