//
//  RootViewController.swift
//  CurrencyConverter
//
//  Created by Tim Neal on 3/27/21.
//  Copyright © 2021 Tim Neal. All rights reserved.
//

import UIKit
import CoreData

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
    
//    var items = [CurrencyEntity]()
//    var savedFavorites:[Favorite]?
    
    // access to AppDelegate as an object
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
//    let currencyExchangeManager = CurrencyExchangeManager()

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
        let baseTextDouble = Double(baseText) ?? 0.0
        var convertedText = String(format: "%.2f", (baseTextDouble * 2.0))
        if convertedText.count <= 2 {
            convertedText.append("0")
        }
        convertedAmountLabel.text = convertedText
    }
    
//    func fetchCurrencies() {
//        let request: NSFetchRequest<CurrencyEntity> = CurrencyEntity.fetchRequest()
//
//        do {
//            items = try context.fetch(request)
//        } catch {
//            print("Error fetching data from context \(error)")
//        }
//
//        // lets see what is being fetched, and placed into items
//        for item in items {
//            print(item.currencyCode!, item.favorite)
//        }
//    }
    
//    func fetchFavorites() {
//        let request: NSFetchRequest<Favorite> = Favorite.fetchRequest()
//        do {
//            self.savedFavorites = try context.fetch(request)
//        } catch {
//            print("Error fetching \(error)")
//        }
//    }
    
    // transfers what is in our scratchpad to permenant data storage
//    func saveCurrencies() {
//        print("saving currenices...")
//        do {
//            try context.save()
//        } catch {
//            print("Error saving currencies \(error)")
//        }
//    }
    
//    func setFavorites() {
//        var currentFavorites: [String] = []
//        for i in 0...2 {
//            currentFavorites.append(savedFavorites?[i].currencyCode ?? "Err")
//        }
//        setFavoritesUI(currencies: currentFavorites)
//    }
    
//    @objc func notificationReceived(_ notification: Notification) {
//        saveCurrencies()
//        fetchFavorites()
//        setFavorites()
//        let currency = currenciesDataModel.currencyObjects[indexPath.section]
//        setFavoritesUI(currencies: currenciesDataModel.favorites)
//        print(currenciesDataModel.favorites)
//        print(savedFavorites?[0].currencyCode)
        
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
//        fetchCurrencies()
//        fetchFavorites()
//        setFavorites()
//        print(savedCurrencies)
//        currencies = createArray()
//        currencyExchangeManager.getExchangeRate(for: "USD")
        
        setBaseCurrencyUI(currencyCode: "USD")
        setConvertedUI(currencyCode: "GBP")
//        setFavoritesUI(currencies: currenciesDataModel.favorites)
//        NotificationCenter.default.addObserver(self, selector: #selector(notificationReceived(_:)), name: Notifications.publishNotification, object: nil)
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
    @IBAction func leftCountryButton(_ sender: UIButton) {
        print("left country tapped")
//        let tappedCountry = savedFavorites?[0].currencyCode ?? "Err"
//        let currentConvertedCountry = convertedCurrencyCodeLabel.text ?? "Err"
//        savedFavorites?[0].currencyCode = currentConvertedCountry
//        setConvertedUI(currencyCode: tappedCountry)
//        leftCountryImage.image = UIImage(named: currentConvertedCountry)
//        leftCountryLabel.text = currentConvertedCountry
        
//        print(items[0].favorite)
//        items[0].favorite = !(items[0].favorite)
//        print(items[0].favorite)
//        print(items[0].countryName)
//
//        self.saveCurrencies()
    }
    
    @IBAction func middleCountryButton(_ sender: UIButton) {
        print("middle country tapped")
//        let tappedCountry = savedFavorites?[1].currencyCode ?? "Err"
//        let currentConvertedCountry = convertedCurrencyCodeLabel.text ?? "Err"
//        savedFavorites?[1].currencyCode = currentConvertedCountry
//        setConvertedUI(currencyCode: tappedCountry)
//        middleCountryImage.image = UIImage(named: currentConvertedCountry)
//        middleCountryLabel.text = currentConvertedCountry
//
//        saveCurrencies()
    }
    
    @IBAction func rightCountryButton(_ sender: UIButton) {
        print("right country tapped")
//        let tappedCountry = savedFavorites?[2].currencyCode ?? "Err"
//        let currentConvertedCountry = convertedCurrencyCodeLabel.text ?? "Err"
//        savedFavorites?[2].currencyCode = currentConvertedCountry
//        setConvertedUI(currencyCode: tappedCountry)
//        rightCountryImage.image = UIImage(named: currentConvertedCountry)
//        rightCountryLabel.text = currentConvertedCountry
//
//        saveCurrencies()
    }
    
    @IBAction func swapCurrencies(_ sender: UIButton) {
        print("Swap button tapped")
        
//        let currentBaseCountry = baseCurrencyCodeLabel.text!
//        let currentConvertedCountry = convertedCurrencyCodeLabel.text!
//
//        setBaseCurrencyUI(currencyCode: currentConvertedCountry)
//        setConvertedUI(currencyCode: currentBaseCountry)
    }
}
