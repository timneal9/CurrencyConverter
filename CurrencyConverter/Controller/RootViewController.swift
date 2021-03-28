//
//  RootViewController.swift
//  CurrencyConverter
//
//  Created by Tim Neal on 3/27/21.
//  Copyright © 2021 Tim Neal. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    @IBOutlet weak var CurrencyTableView: UITableView!
    
    let currencyArray = ["USA", "GBP"]
    
    var currencies: [Currency] = []
    let cellSpacingHeight: CGFloat = 8
    
    let currencyExchangeManager = CurrencyExchangeManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        CurrencyTableView.delegate = self
        CurrencyTableView.dataSource = self
        CurrencyTableView.tableFooterView = UIView()
        currencies = createArray()
        print(currencies)
        
        currencyExchangeManager.getExchangeRate(for: "USD")
    }
    
    func createArray() -> [Currency] {
        
        var currencies: [Currency] = []
        
        for item in currencyArray {
            let newCurrency = Currency(image: item, country: item, amountLabel: "0.00")
            currencies.append(newCurrency)
        }
        return currencies
    }
    
}

extension RootViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell") as! CurrencyTableViewCell
        
        cell.setCurrency(currency: currency)
        cell.layer.cornerRadius = 4
        
        return cell
    }
    
}
