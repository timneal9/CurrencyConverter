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

class ChangeFavoritesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var leftCountryLabel: UILabel!
    @IBOutlet weak var middleCountryLabel: UILabel!
    @IBOutlet weak var rightCountryLabel: UILabel!
    @IBOutlet weak var leftCountryImage: UIImageView!
    @IBOutlet weak var middleCountryImage: UIImageView!
    @IBOutlet weak var rightCountryImage: UIImageView!
    
    let currenciesDataModel = Currencies()
    let rootViewController = RootViewController()
    let cellSpacingHeight: CGFloat = 8
    
//    var savedCurrencies:[CurrencyEntity]?
    var savedFavorites:[Favorite]?
    
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    var searchResults: Results<Item>?
    
    func setFavorites() {
        var currentFavorites: [String] = []
        for i in 0...2 {
            currentFavorites.append(savedFavorites?[i].currencyCode ?? "Err")
        }
        setFavoritesUI(currencies: currentFavorites)
        
        
    }
    
    func setFavoritesUI(currencies: [String]) {
        leftCountryLabel.text = currencies[0]
        middleCountryLabel.text = currencies[1]
        rightCountryLabel.text = currencies[2]
        
        leftCountryImage.image = UIImage(named: currencies[0])
        middleCountryImage.image = UIImage(named: currencies[1])
        rightCountryImage.image = UIImage(named: currencies[2])
        
    }
    
//    func fetchCurrencies() {
//        print("fetching currencies...")
//        let request: NSFetchRequest<CurrencyEntity> = CurrencyEntity.fetchRequest()
//        do {
//            self.savedCurrencies = try context.fetch(request)
//        } catch {
//            print("Error fetching \(error)")
//        }
//    }
    
//    func fetchFavorites() {
//        print("fetching favorites...")
//        let request: NSFetchRequest<Favorite> = Favorite.fetchRequest()
//        do {
//            self.savedFavorites = try context.fetch(request)
//        } catch {
//            print("Error fetching \(error)")
//        }
//    }
//
//    func saveCurrencies() {
//        print("saving currenices...")
//        do {
//            try context.save()
//        } catch {
//            print("Error saving \(error)")
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        fetchCurrencies()
//        fetchFavorites()
//        setFavorites()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 120
        tableView.register(UINib(nibName: "CurrencyListCell", bundle: nil), forCellReuseIdentifier: "ReusableCurrencyListCell")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
//        NotificationCenter.default.post(name: Notifications.publishNotification, object: nil, userInfo: nil)
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
        if !currenciesDataModel.favorites.contains(currency.currencyCode) {
            currenciesDataModel.favorites.insert(currency.currencyCode, at: 0)
            currenciesDataModel.favorites.removeLast()
        } else {
            let index = currenciesDataModel.favorites.firstIndex(of: currency.currencyCode)
            currenciesDataModel.favorites.remove(at: index ?? 2)
            currenciesDataModel.favorites.insert(currency.currencyCode, at: 0)
        }
        
        setFavoritesUI(currencies: currenciesDataModel.favorites)
        print(currenciesDataModel.favorites)
        
        for i in 0...2 {
            savedFavorites?[i].currencyCode = currenciesDataModel.favorites[i]
        }
        

        
//        saveCurrencies()

    }

}

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
