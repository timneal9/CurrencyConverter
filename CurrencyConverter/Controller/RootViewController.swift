//
//  RootViewController.swift
//  CurrencyConverter
//
//  Created by Tim Neal on 3/27/21.
//  Copyright © 2021 Tim Neal. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

//    let currencyExchangeManager = CurrencyExchangeManager()

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
    
    @IBAction func threeNumButtonTapped(_ sender: Any) {
        print("3 tapped")
    }
}
