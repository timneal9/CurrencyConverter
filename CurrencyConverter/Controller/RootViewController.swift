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
    
    
    @IBOutlet weak var leftCountryLabel: UILabel!
    @IBOutlet weak var middleCountryLabel: UILabel!
    @IBOutlet weak var rightCountryLabel: UILabel!
    @IBOutlet weak var leftCountryImage: UIImageView!
    @IBOutlet weak var middleCountryImage: UIImageView!
    @IBOutlet weak var rightCountryImage: UIImageView!
    
    let currencyExchangeManager = CurrencyExchangeManager()
    var baseAmount: String = ""
    var decimalActive: Bool = false
    var decimalString: String = ".00"
    var decimalActiveCount: Int = 0
    
    var currencies = [
        Currency(currencyCode: "NZD", currencyName: "New Zealand Dollar", countryName: "New Zealand", amountLabel: "0.00"),
        Currency(currencyCode: "MXN", currencyName: "Mexican Peso", countryName: "Mexico", amountLabel: "0.00"),
        Currency(currencyCode: "EUR", currencyName: "Euro", countryName: "European Union", amountLabel: "0.00")
    ]
    
    func setBaseCurrencyUI(currency: Currency) {
        baseCurrencyCodeLabel.text = currency.currencyCode
        baseFlagImage.image = UIImage(named: currency.currencyCode)
    }
    
    func setConvertedUI(currency: Currency) {
        convertedCurrencyCodeLabel.text = currency.currencyCode
        convertedFlagImage.image = UIImage(named: currency.currencyCode)
    }
    
    func setFavoritesUI(currencies: [Currency]) {
        leftCountryLabel.text = currencies[0].currencyCode
        middleCountryLabel.text = currencies[1].currencyCode
        rightCountryLabel.text = currencies[2].currencyCode
        
        leftCountryImage.image = UIImage(named: currencies[0].currencyCode)
        middleCountryImage.image = UIImage(named: currencies[1].currencyCode)
        rightCountryImage.image = UIImage(named: currencies[2].currencyCode)
    }
    
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
        if convertedText.count <= 2 {
            convertedText.append("0")
        }
        convertedAmountLabel.text = convertedText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        currencies = createArray()

        currencyExchangeManager.getExchangeRate(for: "USD")
        let usd = Currency(currencyCode: "USD", currencyName: "United States Dollar", countryName: "United States", amountLabel: "0.00")
        let gbp = Currency(currencyCode: "GBP", currencyName: "Pound Sterling", countryName: "Great Britian", amountLabel: "0.00")
        setBaseCurrencyUI(currency: usd)
        setConvertedUI(currency: gbp)
        setFavoritesUI(currencies: currencies)
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
