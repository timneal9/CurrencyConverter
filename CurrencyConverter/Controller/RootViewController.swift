//
//  RootViewController.swift
//  CurrencyConverter
//
//  Created by Tim Neal on 3/27/21.
//  Copyright © 2021 Tim Neal. All rights reserved.
//

import UIKit
import CoreData

class RootViewController: UIViewController, UIAdaptivePresentationControllerDelegate {
    @IBOutlet weak var baseAmountLabel: UILabel!
    @IBOutlet weak var baseCurrencyCodeLabel: UILabel!
    @IBOutlet weak var baseFlagImage: UIImageView!
    
    @IBOutlet weak var convertedAmountLabel: UILabel!
    @IBOutlet weak var convertedCurrencyCodeLabel: UILabel!
    @IBOutlet weak var convertedFlagImage: UIImageView!
    @IBOutlet weak var swapArrowView: UIView!
    @IBOutlet weak var swapSpacingView: UIView!
    
    @IBOutlet weak var leftCountryLabel: UILabel!
    @IBOutlet weak var middleCountryLabel: UILabel!
    @IBOutlet weak var rightCountryLabel: UILabel!
    @IBOutlet weak var leftCountryImage: UIImageView!
    @IBOutlet weak var middleCountryImage: UIImageView!
    @IBOutlet weak var rightCountryImage: UIImageView!
    
    @IBOutlet weak var baseCurrencyUIView: UIView!
    @IBOutlet weak var convertedCurrencyUIView: UIView!

    @IBOutlet weak var leftFavView: UIStackView!
    @IBOutlet weak var middleFavView: UIStackView!
    @IBOutlet weak var rightFavView: UIStackView!
    
    let rates = UserDefaults.standard.dictionary(forKey: "ratesDictionary")
    var baseAmount: String = ""
    var decimalActive: Bool = false
    var decimalString: String = ".00"
    var decimalActiveCount: Int = 0
    
    func setBaseCurrencyUI(currencyCode: String) {
        baseCurrencyCodeLabel.text = currencyCode
        baseFlagImage.image = UIImage(named: currencyCode)
    }
    
    func setConvertedUI(currencyCode: String) {
        convertedCurrencyCodeLabel.text = currencyCode
        convertedFlagImage.image = UIImage(named: currencyCode)
        updateConvertedAmount()
    }
    
    func setFavoritesUI(currencies: [String]) {
        leftCountryLabel?.text = currencies[0]
        middleCountryLabel?.text = currencies[1]
        rightCountryLabel?.text = currencies[2]

        leftCountryImage?.image = UIImage(named: currencies[0])
        middleCountryImage?.image = UIImage(named: currencies[1])
        rightCountryImage?.image = UIImage(named: currencies[2])
        
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
        let baseTextFloat = Float(baseText) ?? 0.0
        let baseRateCode = baseCurrencyCodeLabel.text ?? "USD"
        let conversionRateCode = convertedCurrencyCodeLabel.text ?? "USD"
        guard let baseRate = rates?[baseRateCode] as? Float else { return }
        guard let conversionRate = rates?[conversionRateCode] as? Float else { return }
        
        let multiplier = conversionRate / baseRate
        let result = baseTextFloat * multiplier
        var formattedResult = String(format: "%.2f", result)
        
        if formattedResult.count <= 2 {
            formattedResult.append("0")
        }
        convertedAmountLabel.text = formattedResult
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBaseCurrencyUI(currencyCode: AppDelegate.shared().baseCurrency)
        setConvertedUI(currencyCode: AppDelegate.shared().convertedCurrency)
        
        setFavoritesUI(currencies: [
            AppDelegate.shared().leftFavorite,
            AppDelegate.shared().middleFavorite,
            AppDelegate.shared().rightFavorite
        ])
        
        let baseTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(swapCurrencies(tapGestureRecognizer:)))
        let convertedTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(swapCurrencies(tapGestureRecognizer:)))
        let leftFavTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(leftCountryTapped(tapGestureRecognizer:)))
        let middleFavTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(middleCountryTapped(tapGestureRecognizer:)))
        let rightFavTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(rightCountryTapped(tapGestureRecognizer:)))
        let swapSpacingViewTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(swapCurrencies(tapGestureRecognizer:)))
        
        swapArrowView.layer.cornerRadius = swapArrowView.frame.size.width/2
        swapSpacingView.isUserInteractionEnabled = true
        swapSpacingView.addGestureRecognizer(swapSpacingViewTapGestureRecognizer)
        baseCurrencyUIView.isUserInteractionEnabled = true
        baseCurrencyUIView.addGestureRecognizer(baseTapGestureRecognizer)
        convertedCurrencyUIView.isUserInteractionEnabled = true
        convertedCurrencyUIView.addGestureRecognizer(convertedTapGestureRecognizer)
        leftFavView.isUserInteractionEnabled = true
        leftFavView.addGestureRecognizer(leftFavTapGestureRecognizer)
        rightFavView.isUserInteractionEnabled = true
        rightFavView.addGestureRecognizer(rightFavTapGestureRecognizer)
        middleFavView.isUserInteractionEnabled = true
        middleFavView.addGestureRecognizer(middleFavTapGestureRecognizer)
        
        NotificationCenter.default.addObserver(self, selector: #selector(notificationReceived(_:)), name: Notifications.publishNotification, object: nil)
    }
    
    @objc func notificationReceived(_ notification: Notification) {
        
        setFavoritesUI(currencies: [
            AppDelegate.shared().leftFavorite,
            AppDelegate.shared().middleFavorite,
            AppDelegate.shared().rightFavorite
        ])
        AppDelegate.shared().setSavedCurrencyValues()
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
    
    @objc func leftCountryTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let currentConvertedCurrency = AppDelegate.shared().convertedCurrency
        let tappedCurrency = AppDelegate.shared().leftFavorite
        
        AppDelegate.shared().convertedCurrency = tappedCurrency
        AppDelegate.shared().leftFavorite = currentConvertedCurrency
        
        leftCountryImage.image = UIImage(named: AppDelegate.shared().leftFavorite)
        leftCountryLabel.text = AppDelegate.shared().leftFavorite
        
        setConvertedUI(currencyCode: AppDelegate.shared().convertedCurrency)
        AppDelegate.shared().setSavedCurrencyValues()
    }
    
    @objc func middleCountryTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let currentConvertedCurrency = AppDelegate.shared().convertedCurrency
        let tappedCurrency = AppDelegate.shared().middleFavorite
        
        AppDelegate.shared().convertedCurrency = tappedCurrency
        AppDelegate.shared().middleFavorite = AppDelegate.shared().leftFavorite
        AppDelegate.shared().leftFavorite = currentConvertedCurrency
        
        leftCountryImage.image = UIImage(named: AppDelegate.shared().leftFavorite)
        leftCountryLabel.text = AppDelegate.shared().leftFavorite
        middleCountryImage.image = UIImage(named: AppDelegate.shared().middleFavorite)
        middleCountryLabel.text = AppDelegate.shared().middleFavorite

        setConvertedUI(currencyCode: AppDelegate.shared().convertedCurrency)
        AppDelegate.shared().setSavedCurrencyValues()
    }
    
    @objc func rightCountryTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let currentConvertedCurrency = AppDelegate.shared().convertedCurrency
        let tappedCurrency = AppDelegate.shared().rightFavorite
        
        AppDelegate.shared().convertedCurrency = tappedCurrency
        AppDelegate.shared().rightFavorite = AppDelegate.shared().middleFavorite
        AppDelegate.shared().middleFavorite = AppDelegate.shared().leftFavorite
        AppDelegate.shared().leftFavorite = currentConvertedCurrency
        
        leftCountryImage.image = UIImage(named: AppDelegate.shared().leftFavorite)
        leftCountryLabel.text = AppDelegate.shared().leftFavorite
        middleCountryImage.image = UIImage(named: AppDelegate.shared().middleFavorite)
        middleCountryLabel.text = AppDelegate.shared().middleFavorite
        rightCountryImage.image = UIImage(named: AppDelegate.shared().rightFavorite)
        rightCountryLabel.text = AppDelegate.shared().rightFavorite

        setConvertedUI(currencyCode: AppDelegate.shared().convertedCurrency)
        AppDelegate.shared().setSavedCurrencyValues()
        
    }
    
    @objc func swapCurrencies(tapGestureRecognizer: UITapGestureRecognizer) {
        let currentBaseCountry = AppDelegate.shared().baseCurrency
        let currentConvertedCountry = AppDelegate.shared().convertedCurrency
        
        AppDelegate.shared().baseCurrency = currentConvertedCountry
        AppDelegate.shared().convertedCurrency = currentBaseCountry

        setBaseCurrencyUI(currencyCode: AppDelegate.shared().baseCurrency)
        setConvertedUI(currencyCode: AppDelegate.shared().convertedCurrency)
        AppDelegate.shared().setSavedCurrencyValues()
    }
}
