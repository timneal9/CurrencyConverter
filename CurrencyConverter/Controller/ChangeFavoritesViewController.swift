//
//  ChangeFavoritesViewController.swift
//  CurrencyConverter
//
//  Created by Tim Neal on 3/30/21.
//  Copyright © 2021 Tim Neal. All rights reserved.
//

import Foundation
import UIKit

class ChangeFavoritesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    let currencyArray = ["CAD":"Canadian Dollar",
                         "HKD":"Hong Kong Dollar",
                         "ISK":"Iceland Krona",
                         "PHP":"Philippine Peso",
                         "DKK":"Danish Krone",
                         "HUF":"Forint",
                         "CZK":"Czech Koruna",
                         "AUD":"Australian Dollar",
                         "RON":"Romanian Leu",
                         "SEK":"Swedish Krona",
                         "IDR":"Indian Rupee",
                         "INR":"Indian Rupee",
                         "BRL":"Brazilian Real",
                         "RUB":"Russian Ruble",
                         "HRK":"Kuna",
                         "JPY":"Yen",
                         "THB":"Baht",
                         "CHF":"Swiss Franc",
                         "SGD":"Singapore Dollar",
                         "PLN":"Zloty",
                         "BGN":"Bulgarian Lev",
                         "TRY":"Turkish Lira",
                         "CNY":"Yuan Renminbi",
                         "NOK":"Norwegian Krone",
                         "NZD":"New Zealand Dollar",
                         "ZAR":"Rand",
                         "USD":"United States Dollar",
                         "MXN":"Mexican Peso",
                         "ILS":"New Israeli Sheqel",
                         "GBP":"Pound Sterling",
                         "KRW":"Won",
                         "MYR":"Malaysian Ringgit"]
    
    
    
    let cellSpacingHeight: CGFloat = 8
    var currencies: [Currency] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencies = createArray()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 120
        tableView.register(UINib(nibName: "CurrencyListCell", bundle: nil), forCellReuseIdentifier: "ReusableCurrencyListCell")
    }

    func createArray() -> [Currency] {

        var currencies: [Currency] = []

//        for currency in currencyArray {
//            let newCurrency = Currency(currencyCode: currency.key, currencyName: currency.value, amountLabel: "0.00")
//            currencies.append(newCurrency)
//        }
        
        currencies = [
            Currency(currencyCode: "USD", currencyName: "United States Dollar", countryName: "United States", amountLabel: "0.00"),
            Currency(currencyCode: "GBP", currencyName: "Pound Sterling", countryName: "Great Britian", amountLabel: "0.00"),
            Currency(currencyCode: "NZD", currencyName: "New Zealand Dollar", countryName: "New Zealand", amountLabel: "0.00"),
            Currency(currencyCode: "MXN", currencyName: "Mexican Peso", countryName: "Mexico", amountLabel: "0.00"),
            Currency(currencyCode: "EUR", currencyName: "Euro", countryName: "European Union", amountLabel: "0.00")
        ]
//
        
        return currencies
    }
}

extension ChangeFavoritesViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return currencies.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return cellSpacingHeight
        }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
            headerView.backgroundColor = UIColor.clear
            return headerView
        }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let currency = currencies[indexPath.section]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCurrencyListCell") as! CurrencyListCell

        cell.currencyCodeLabel.text = currency.currencyCode
        cell.currencyExpandedLabel.text = currency.currencyName
        cell.countryNameLabel.text = currency.countryName
        cell.flagImageView.image = UIImage(named: currency.currencyCode)
        cell.layer.cornerRadius = 4
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currency = currencies[indexPath.section]
        print("Row selected \(currency)")
    }

}
