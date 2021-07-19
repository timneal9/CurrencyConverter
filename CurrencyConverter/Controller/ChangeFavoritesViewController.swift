//
//  ChangeFavoritesViewController.swift
//  CurrencyConverter
//
//  Created by Tim Neal on 3/30/21.
//  Copyright © 2021 Tim Neal. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ChangeFavoritesViewController: UIViewController, UIAdaptivePresentationControllerDelegate {
    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var leftCountryLabel: UILabel!
    @IBOutlet weak var middleCountryLabel: UILabel!
    @IBOutlet weak var rightCountryLabel: UILabel!
    @IBOutlet weak var leftCountryImage: UIImageView!
    @IBOutlet weak var middleCountryImage: UIImageView!
    @IBOutlet weak var rightCountryImage: UIImageView!
    
    var currencyArray = [CurrencyEntity]()
    //    var searchResults: Results<Item>?
    
    let cellSpacingHeight: CGFloat = 8
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func setFavoritesUI(currencies: [String]) {
        leftCountryLabel?.text = currencies[0]
        middleCountryLabel?.text = currencies[1]
        rightCountryLabel?.text = currencies[2]

        leftCountryImage?.image = UIImage(named: currencies[0])
        middleCountryImage?.image = UIImage(named: currencies[1])
        rightCountryImage?.image = UIImage(named: currencies[2])
    }
    
    func fetchCurrencies() {
        print("fetching currencies...")
        let request: NSFetchRequest<CurrencyEntity> = CurrencyEntity.fetchRequest()
        do {
            self.currencyArray = try context.fetch(request)
        } catch {
            print("Error fetching \(error)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCurrencies()
        
        setFavoritesUI(currencies: [
            AppDelegate.shared().leftFavorite,
            AppDelegate.shared().middleFavorite,
            AppDelegate.shared().rightFavorite
        ])
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 120
        tableView.register(UINib(nibName: "CurrencyListCell", bundle: nil), forCellReuseIdentifier: "ReusableCurrencyListCell")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        AppDelegate.shared().setSavedCurrencyValues()
        NotificationCenter.default.post(name: Notifications.publishNotification, object: nil, userInfo: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
    }
}

extension ChangeFavoritesViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return currencyArray.count
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

        let currency = currencyArray[indexPath.section]        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCurrencyListCell") as! CurrencyListCell

        cell.currencyCodeLabel.text = currency.currencyCode
        cell.currencyExpandedLabel.text = currency.currencyName
        cell.countryNameLabel.text = currency.countryName
        cell.flagImageView.image = UIImage(named: currency.currencyCode ?? "Err")
        cell.layer.cornerRadius = 4
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tappedCurrency = currencyArray[indexPath.section].currencyCode ?? "Err"
        let currentFavs = [
            AppDelegate.shared().leftFavorite,
            AppDelegate.shared().middleFavorite,
            AppDelegate.shared().rightFavorite
        ]
        
        
        if !(currentFavs.contains(tappedCurrency)) {
            AppDelegate.shared().rightFavorite = AppDelegate.shared().middleFavorite
            AppDelegate.shared().middleFavorite = AppDelegate.shared().leftFavorite
            AppDelegate.shared().leftFavorite = tappedCurrency
        } else {
            switch tappedCurrency {
            case AppDelegate.shared().middleFavorite:
                AppDelegate.shared().middleFavorite = AppDelegate.shared().leftFavorite
            case AppDelegate.shared().rightFavorite:
                AppDelegate.shared().rightFavorite = AppDelegate.shared().middleFavorite
                AppDelegate.shared().middleFavorite = AppDelegate.shared().leftFavorite
            default:
                print("Switch statement exhausted, did not match right or middle favorites.")
                print("Tapped currency is already in the left position: \(tappedCurrency == AppDelegate.shared().leftFavorite)")
            }
            AppDelegate.shared().leftFavorite = tappedCurrency
        }
        setFavoritesUI(currencies: [
            AppDelegate.shared().leftFavorite,
            AppDelegate.shared().middleFavorite,
            AppDelegate.shared().rightFavorite
        ])
    }
}


// MARK: Future feature, search bar

//extension ChangeFavoritesViewController: UISearchBarDelegate {
//    func searchItems(_ searchBar: UISearchBar) {
//        searchResults = currencies?.filter("title CONTAINS[cd] %@", searchBar.text!)
//            .sorted(byKeyPath: "dateCreated", ascending: true)
//
//        tableView.reloadData()
//    }
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        searchItems(searchBar)
//    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text?.count == 0 {
//            loadItems()
//
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()
//            }
//        } else {
//            searchItems(searchBar)
//        }
//    }
//}
