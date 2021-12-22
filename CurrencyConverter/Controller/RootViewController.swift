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
    
    @IBOutlet weak var baseFlagStack: UIStackView!
    @IBOutlet weak var convertedFlagStack: UIStackView!
    @IBOutlet weak var leftFavStack: UIStackView!
    @IBOutlet weak var middleFavStack: UIStackView!
    @IBOutlet weak var rightFavStack: UIStackView!
    
    @IBOutlet weak var convertedAmountLabel: UILabel!
    @IBOutlet weak var convertedCurrencyCodeLabel: UILabel!
    @IBOutlet weak var convertedFlagImage: UIImageView!
    @IBOutlet weak var swapArrowView: UIView!
    
    @IBOutlet weak var leftCountryLabel: UILabel!
    @IBOutlet weak var middleCountryLabel: UILabel!
    @IBOutlet weak var rightCountryLabel: UILabel!
    @IBOutlet weak var leftCountryImage: UIImageView!
    @IBOutlet weak var middleCountryImage: UIImageView!
    @IBOutlet weak var rightCountryImage: UIImageView!
    
    @IBOutlet weak var baseCurrencyUIView: UIView!
    @IBOutlet weak var convertedCurrencyUIView: UIView!
    @IBOutlet weak var favCurrencyUIView: UIView!
    
    @IBOutlet weak var leftFavView: UIStackView!
    @IBOutlet weak var middleFavView: UIStackView!
    @IBOutlet weak var rightFavView: UIStackView!
    
    var rates = UserDefaults.standard.dictionary(forKey: Constants.ratesDictionaryKey)
    var baseAmount: String = "0"
    var decimalActive: Bool = false
    var decimalString: String = ".00"
    var decimalActiveCount: Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let baseTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(swapCurrencies(tapGestureRecognizer:)))
        let convertedTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(swapCurrencies(tapGestureRecognizer:)))
        let leftFavTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(leftCountryTapped(tapGestureRecognizer:)))
        let middleFavTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(middleCountryTapped(tapGestureRecognizer:)))
        let rightFavTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(rightCountryTapped(tapGestureRecognizer:)))
        
        updateRates()
        setBaseCurrencyUI(currencyCode: AppDelegate.shared().baseCurrency)
        setConvertedUI(currencyCode: AppDelegate.shared().convertedCurrency)
        setFavoritesUI(currencies: [
            AppDelegate.shared().leftFavorite,
            AppDelegate.shared().middleFavorite,
            AppDelegate.shared().rightFavorite
        ])
        setShadows()
        setupAccessibility()
        
        swapArrowView.layer.cornerRadius = swapArrowView.frame.size.width/2
        swapArrowView.isUserInteractionEnabled = true
        swapArrowView.topAnchor.constraint(equalTo: baseCurrencyUIView.bottomAnchor, constant: -8.0).isActive = true
        
        baseFlagStack.isUserInteractionEnabled = true
        baseFlagStack.addGestureRecognizer(baseTapGestureRecognizer)
        convertedFlagStack.isUserInteractionEnabled = true
        convertedFlagStack.addGestureRecognizer(convertedTapGestureRecognizer)
        
        baseCurrencyUIView.layer.cornerRadius = 10
        convertedCurrencyUIView.layer.cornerRadius = 10
        favCurrencyUIView.layer.cornerRadius = 10
        
        leftFavView.isUserInteractionEnabled = true
        leftFavView.addGestureRecognizer(leftFavTapGestureRecognizer)
        rightFavView.isUserInteractionEnabled = true
        rightFavView.addGestureRecognizer(rightFavTapGestureRecognizer)
        middleFavView.isUserInteractionEnabled = true
        middleFavView.addGestureRecognizer(middleFavTapGestureRecognizer)
        
        NotificationCenter.default.addObserver(self, selector: #selector(notificationReceived(_:)), name: Notifications.publishNotification, object: nil)
    }
    
    func setBaseCurrencyUI(currencyCode: String) {
        baseCurrencyCodeLabel.text = currencyCode
        baseFlagImage.image = fetchImage(currencyCode: currencyCode)
    }
    
    func setConvertedUI(currencyCode: String) {
        convertedCurrencyCodeLabel.text = currencyCode
        convertedFlagImage.image = fetchImage(currencyCode: currencyCode)
        updateConvertedAmount()
        updateAccessibilityLabels()
    }
    
    func setFavoritesUI(currencies: [String]) {
        leftCountryLabel?.text = currencies[0]
        middleCountryLabel?.text = currencies[1]
        rightCountryLabel?.text = currencies[2]
        
        leftCountryImage?.image = fetchImage(currencyCode: currencies[0])
        middleCountryImage?.image = fetchImage(currencyCode: currencies[1])
        rightCountryImage?.image = fetchImage(currencyCode: currencies[2])
        
        updateAccessibilityLabels()
    }
    
    func validateCode(currencyCode: String) -> String {
        if (UIImage(named: currencyCode) == nil) {
            return "ERR"
        }
        return currencyCode
    }
    
    func fetchImage(currencyCode: String) -> UIImage {
        if let image = (UIImage(named: currencyCode)) {
            return image
        }
        return UIImage(named: "ERR")!
    }
    
    func numButtonTapped(num: String) {
        if decimalActive {
            if decimalActiveCount == 0 {
                decimalString = ".00"
            }
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
            resetDecimalCount()
        }
    }
    
    func resetDecimalCount() {
        decimalActive = false
        decimalActiveCount = 0
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
        resetDecimalCount()
        updateBaseAmount()
    }
    
    func updateBaseAmount() {
        baseAmountLabel.text = baseAmount + decimalString
        updateRates()
        updateConvertedAmount()
        updateAccessibilityLabels()
    }
    
    func updateConvertedAmount() {
        let baseText = baseAmountLabel.text ?? "0.0"
        let baseTextDouble = Double(baseText) ?? 0.0
        let baseRateCode = validateCode(currencyCode: baseCurrencyCodeLabel.text ?? "ERR")
        let conversionRateCode = validateCode(currencyCode: convertedCurrencyCodeLabel.text ?? "ERR")
        guard let baseRate = rates?[baseRateCode] as? Double else { return }
        guard let conversionRate = rates?[conversionRateCode] as? Double else { return }
        
        let multiplier = conversionRate / baseRate
        let result = baseTextDouble * multiplier
        var formattedResult = String(format: "%.2f", result)
        
        if formattedResult.count <= 2 {
            formattedResult.append("0")
        }
        convertedAmountLabel.text = formattedResult
    }
    
    func isPremiumUser() -> Bool {
        let isPremiumUser = UserDefaults.standard.bool(forKey: Constants.premiumUserKey)
        return isPremiumUser
    }
    
    func updateRates() {
        rates = UserDefaults.standard.dictionary(forKey: Constants.ratesDictionaryKey)
    }
    
    func setShadows() {
        baseFlagImage.clipsToBounds = false
        baseFlagImage.layer.shadowPath = UIBezierPath(rect: baseFlagImage.bounds).cgPath
        baseFlagImage.layer.shadowOpacity = 0.2
        baseFlagImage.layer.shadowOffset = .zero
        baseFlagImage.layer.shadowRadius = 5
        
        convertedFlagImage.clipsToBounds = false
        convertedFlagImage.layer.shadowPath = UIBezierPath(rect: convertedFlagImage.bounds).cgPath
        convertedFlagImage.layer.shadowOpacity = 0.2
        convertedFlagImage.layer.shadowOffset = .zero
        convertedFlagImage.layer.shadowRadius = 5
        
        leftCountryImage.clipsToBounds = false
        leftCountryImage.layer.shadowPath = UIBezierPath(rect: leftCountryImage.bounds).cgPath
        leftCountryImage.layer.shadowOpacity = 0.2
        leftCountryImage.layer.shadowOffset = .zero
        leftCountryImage.layer.shadowRadius = 5
        
        middleCountryImage.clipsToBounds = false
        middleCountryImage.layer.shadowPath = UIBezierPath(rect: middleCountryImage.bounds).cgPath
        middleCountryImage.layer.shadowOpacity = 0.2
        middleCountryImage.layer.shadowOffset = .zero
        middleCountryImage.layer.shadowRadius = 5
        
        rightCountryImage.clipsToBounds = false
        rightCountryImage.layer.shadowPath = UIBezierPath(rect: rightCountryImage.bounds).cgPath
        rightCountryImage.layer.shadowOpacity = 0.2
        rightCountryImage.layer.shadowOffset = .zero
        rightCountryImage.layer.shadowRadius = 5
        
        baseCurrencyUIView.clipsToBounds = false
        baseCurrencyUIView.layer.shadowOpacity = 0.1
        baseCurrencyUIView.layer.shadowOffset = .zero
        baseCurrencyUIView.layer.shadowRadius = 2
        
        convertedCurrencyUIView.clipsToBounds = false
        convertedCurrencyUIView.layer.shadowOpacity = 0.1
        convertedCurrencyUIView.layer.shadowOffset = .zero
        convertedCurrencyUIView.layer.shadowRadius = 2
        
        favCurrencyUIView.clipsToBounds = false
        favCurrencyUIView.layer.shadowOpacity = 0.1
        favCurrencyUIView.layer.shadowOffset = .zero
        favCurrencyUIView.layer.shadowRadius = 2
    }
    
    func setupAccessibility() {
        baseCurrencyCodeLabel.isAccessibilityElement = false
        baseFlagImage.isAccessibilityElement = false
        baseFlagStack.isAccessibilityElement = true
        baseFlagStack.accessibilityHint = "Double tap to swap base and quote currencies"
        
        convertedCurrencyCodeLabel.isAccessibilityElement = false
        convertedFlagImage.isAccessibilityElement = false
        convertedFlagStack.isAccessibilityElement = true
        convertedFlagStack.accessibilityHint = "Double tap to swap base and quote currencies"
        
        leftCountryLabel.isAccessibilityElement = false
        leftCountryImage.isAccessibilityElement = false
        leftFavStack.isAccessibilityElement = true
        
        middleCountryLabel.isAccessibilityElement = false
        middleCountryImage.isAccessibilityElement = false
        middleFavStack.isAccessibilityElement = true
        
        rightCountryLabel.isAccessibilityElement = false
        rightCountryImage.isAccessibilityElement = false
        rightFavStack.isAccessibilityElement = true
        
        baseAmountLabel.isAccessibilityElement = true
        convertedAmountLabel.isAccessibilityElement = true
        
        swapArrowView.isAccessibilityElement = true
        swapArrowView.accessibilityLabel = "Swap currencies"
        swapArrowView.accessibilityHint = "Double tap to swap base and quote currencies"
    }
    
    func updateAccessibilityLabels() {
        baseFlagStack.accessibilityLabel = "Base currency " + (baseCurrencyCodeLabel.text ?? "")
        convertedFlagStack.accessibilityLabel = "Quote currency " + (convertedCurrencyCodeLabel.text ?? "")
        leftFavStack.accessibilityLabel = "First favorite currency " + (leftCountryLabel.text ?? "")
        middleFavStack.accessibilityLabel = "Second favorite currency " + (middleCountryLabel.text ?? "")
        rightFavStack.accessibilityLabel = "Third favorite currency " + (rightCountryLabel.text ?? "")
        baseAmountLabel.accessibilityLabel = "Base currency amount " + (baseAmountLabel.text ?? "")
        convertedAmountLabel.accessibilityLabel = "Quote currency amount " + (convertedAmountLabel.text ?? "")
    }
    
    func swapCurrencies() {
        let currentBaseCountry = AppDelegate.shared().baseCurrency
        let currentConvertedCountry = AppDelegate.shared().convertedCurrency
        
        AppDelegate.shared().baseCurrency = currentConvertedCountry
        AppDelegate.shared().convertedCurrency = currentBaseCountry
        
        setBaseCurrencyUI(currencyCode: AppDelegate.shared().baseCurrency)
        setConvertedUI(currencyCode: AppDelegate.shared().convertedCurrency)
        AppDelegate.shared().setSavedCurrencyValues()
    }
    
    @objc func notificationReceived(_ notification: Notification) {
        setFavoritesUI(currencies: [
            AppDelegate.shared().leftFavorite,
            AppDelegate.shared().middleFavorite,
            AppDelegate.shared().rightFavorite
        ])
        AppDelegate.shared().setSavedCurrencyValues()
    }
    
    // MARK: - UITapGestureRecognizer
    @objc func leftCountryTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let currentConvertedCurrency = AppDelegate.shared().convertedCurrency
        let tappedCurrency = AppDelegate.shared().leftFavorite
        
        AppDelegate.shared().convertedCurrency = tappedCurrency
        AppDelegate.shared().leftFavorite = currentConvertedCurrency
        
        leftCountryImage.image = fetchImage(currencyCode: AppDelegate.shared().leftFavorite)
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
        
        leftCountryImage.image = fetchImage(currencyCode: AppDelegate.shared().leftFavorite)
        leftCountryLabel.text = AppDelegate.shared().leftFavorite
        middleCountryImage.image = fetchImage(currencyCode: AppDelegate.shared().middleFavorite)
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
        
        leftCountryImage.image = fetchImage(currencyCode: AppDelegate.shared().leftFavorite)
        leftCountryLabel.text = AppDelegate.shared().leftFavorite
        middleCountryImage.image = fetchImage(currencyCode: AppDelegate.shared().middleFavorite)
        middleCountryLabel.text = AppDelegate.shared().middleFavorite
        rightCountryImage.image = fetchImage(currencyCode: AppDelegate.shared().rightFavorite)
        rightCountryLabel.text = AppDelegate.shared().rightFavorite
        
        setConvertedUI(currencyCode: AppDelegate.shared().convertedCurrency)
        AppDelegate.shared().setSavedCurrencyValues()
    }
    
    @objc func swapCurrencies(tapGestureRecognizer: UITapGestureRecognizer) {
        swapCurrencies()
    }
    
    // MARK: - UIButton Actions
    @IBAction func swapArrowsButton(_ sender: Any) {
        swapCurrencies()
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        if isPremiumUser() {
            self.performSegue(withIdentifier: Constants.homeToChangeSegue, sender: self)
        } else {
            self.performSegue(withIdentifier: Constants.homeToPurchasePremiumSegue, sender: self)
        }
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
    @IBAction func swipedLeft(_ sender: Any) {
        deleteNum()
    }
}
