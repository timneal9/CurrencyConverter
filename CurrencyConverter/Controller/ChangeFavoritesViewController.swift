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
  
    let currencies = Currencies()
    let cellSpacingHeight: CGFloat = 8
//    var currencies: [Currency] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 120
        tableView.register(UINib(nibName: "CurrencyListCell", bundle: nil), forCellReuseIdentifier: "ReusableCurrencyListCell")
    }

//    func createArray() -> [Currency] {
//
//        var currencies: [Currency] = []
//        for currency in currencyArray {
//            let newCurrency = Currency(currencyCode: currency.key, currencyName: currency.value, amountLabel: "0.00")
//            currencies.append(newCurrency)
//        }
//        return currencies
//    }
}

extension ChangeFavoritesViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return currencies.currenciesObjects.count
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

        let currency = currencies.currenciesObjects[indexPath.section]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCurrencyListCell") as! CurrencyListCell

        cell.currencyCodeLabel.text = currency.currencyCode
        cell.currencyExpandedLabel.text = currency.currencyName
        cell.countryNameLabel.text = currency.countryName
        cell.flagImageView.image = UIImage(named: currency.currencyCode)
        cell.layer.cornerRadius = 4
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currency = currencies.currenciesObjects[indexPath.section]
        print("Row selected \(currency)")
    }

}
