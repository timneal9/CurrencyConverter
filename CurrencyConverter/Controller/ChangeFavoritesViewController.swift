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
    @IBOutlet weak var leftCountryLabel: UILabel!
    @IBOutlet weak var middleCountryLabel: UILabel!
    @IBOutlet weak var rightCountryLabel: UILabel!
    @IBOutlet weak var leftCountryImage: UIImageView!
    @IBOutlet weak var middleCountryImage: UIImageView!
    @IBOutlet weak var rightCountryImage: UIImageView!
    
    let currenciesDataModel = Currencies()
    let rootViewController = RootViewController()
    let cellSpacingHeight: CGFloat = 8
    
    func setFavorites() {
        currenciesDataModel.favorites = currenciesDataModel.favorites
    }
    
    func setFavoritesUI(currencies: [Currency]) {
        leftCountryLabel.text = currencies[0].currencyCode
        middleCountryLabel.text = currencies[1].currencyCode
        rightCountryLabel.text = currencies[2].currencyCode
        
        leftCountryImage.image = UIImage(named: currencies[0].currencyCode)
        middleCountryImage.image = UIImage(named: currencies[1].currencyCode)
        rightCountryImage.image = UIImage(named: currencies[2].currencyCode)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFavorites()
        setFavoritesUI(currencies: currenciesDataModel.favorites)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 120
        tableView.register(UINib(nibName: "CurrencyListCell", bundle: nil), forCellReuseIdentifier: "ReusableCurrencyListCell")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.post(name: Notifications.publishNotification, object: nil, userInfo: nil)
    }
}

extension ChangeFavoritesViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return currenciesDataModel.currencyObjects.count
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

        let currency = currenciesDataModel.currencyObjects[indexPath.section]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCurrencyListCell") as! CurrencyListCell

        cell.currencyCodeLabel.text = currency.currencyCode
        cell.currencyExpandedLabel.text = currency.currencyName
        cell.countryNameLabel.text = currency.countryName
        cell.flagImageView.image = UIImage(named: currency.currencyCode)
        cell.layer.cornerRadius = 4
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currency = currenciesDataModel.currencyObjects[indexPath.section]
        if !currenciesDataModel.favorites.contains(currency) {
            currenciesDataModel.favorites.insert(currency, at: 0)
            currenciesDataModel.favorites.removeLast()
        } else {
            let index = currenciesDataModel.favorites.firstIndex(of: currency)
            currenciesDataModel.favorites.remove(at: index ?? 2)
            currenciesDataModel.favorites.insert(currency, at: 0)
        }
        setFavoritesUI(currencies: currenciesDataModel.favorites)
    }

}
