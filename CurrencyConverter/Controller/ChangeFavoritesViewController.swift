//
//  ChangeFavoritesViewController.swift
//  CurrencyConverter
//
//  Created by Tim Neal on 3/30/21.
//  Copyright © 2021 Tim Neal. All rights reserved.
//

import Foundation
import UIKit

class ChangeFavoritesViewController: UIViewController, UIAdaptivePresentationControllerDelegate, UISearchBarDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var leftCountryLabel: UILabel!
    @IBOutlet weak var middleCountryLabel: UILabel!
    @IBOutlet weak var rightCountryLabel: UILabel!
    @IBOutlet weak var leftCountryImage: UIImageView!
    @IBOutlet weak var middleCountryImage: UIImageView!
    @IBOutlet weak var rightCountryImage: UIImageView!
    @IBOutlet weak var favCurrencyView: UIView!
    @IBOutlet weak var leftFavStack: UIStackView!
    @IBOutlet weak var middleFavStack: UIStackView!
    @IBOutlet weak var rightFavStack: UIStackView!
    
    var currencyArray = [Currency]()
    var filteredCurrencies = [Currency]()
    
    let cellSpacingHeight: CGFloat = 8
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Currencies"
        searchController.searchBar.sizeToFit()
        searchController.searchBar.searchBarStyle = .prominent
        searchController.searchBar.delegate = self
        
        return searchController
    }()
    
    func setFavoritesUI(currencies: [String]) {
        leftCountryLabel?.text = currencies[0]
        middleCountryLabel?.text = currencies[1]
        rightCountryLabel?.text = currencies[2]

        leftCountryImage?.image = UIImage(named: validateCode(currencyCode: currencies[0]))
        middleCountryImage?.image = UIImage(named: validateCode(currencyCode: currencies[1]))
        rightCountryImage?.image = UIImage(named: validateCode(currencyCode: currencies[2]))
        
        updateAccessibilityLabels()
    }
    
    func validateCode(currencyCode: String) -> String {
        if (UIImage(named: currencyCode) != nil) {
            return currencyCode
        } else {
            return "ERR"
        }
    }
    
    func fetchCurrencies() {
        currencyArray = Currencies().currencyObjects
        currencyArray = currencyArray.sorted(by: { $0.countryName < $1.countryName })
    }
    
    func filterContentForSearchText(searchText: String) {
        if isSearchBarEmpty() {
            filteredCurrencies = currencyArray
        } else {
            filteredCurrencies = currencyArray.filter({ (currency: Currency) -> Bool in
                if isSearchBarEmpty() {
                    return false
                } else {
                    return currency.countryName.lowercased().contains(searchText.lowercased()) ||
                        currency.currencyCode.lowercased().contains(searchText.lowercased()) ||
                        currency.currencyName.lowercased().contains(searchText.lowercased())
                }
            })
        }
        tableView.reloadData()
    }
    
    func isSearchBarEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive
    }
    
    func setShadows() {
        favCurrencyView.layer.cornerRadius = 10
        favCurrencyView.clipsToBounds = false
        favCurrencyView.layer.shadowOpacity = 0.1
        favCurrencyView.layer.shadowOffset = .zero
        favCurrencyView.layer.shadowRadius = 2
        
        leftCountryImage.clipsToBounds = false
        leftCountryImage.layer.shadowPath = UIBezierPath(rect: rightCountryImage.bounds).cgPath
        leftCountryImage.layer.shadowOpacity = 0.2
        leftCountryImage.layer.shadowOffset = .zero
        leftCountryImage.layer.shadowRadius = 5
        
        middleCountryImage.clipsToBounds = false
        middleCountryImage.layer.shadowPath = UIBezierPath(rect: rightCountryImage.bounds).cgPath
        middleCountryImage.layer.shadowOpacity = 0.2
        middleCountryImage.layer.shadowOffset = .zero
        middleCountryImage.layer.shadowRadius = 5
        
        rightCountryImage.clipsToBounds = false
        rightCountryImage.layer.shadowPath = UIBezierPath(rect: rightCountryImage.bounds).cgPath
        rightCountryImage.layer.shadowOpacity = 0.2
        rightCountryImage.layer.shadowOffset = .zero
        rightCountryImage.layer.shadowRadius = 5
    }
    
    func setupAccessibility() {
        leftCountryLabel.isAccessibilityElement = false
        leftCountryImage.isAccessibilityElement = false
        leftFavStack.isAccessibilityElement = true
        
        middleCountryLabel.isAccessibilityElement = false
        middleCountryImage.isAccessibilityElement = false
        middleFavStack.isAccessibilityElement = true
        
        rightCountryLabel.isAccessibilityElement = false
        rightCountryImage.isAccessibilityElement = false
        rightFavStack.isAccessibilityElement = true
    }
    
    func updateAccessibilityLabels() {
        leftFavStack.accessibilityLabel = "First favorite currency " + (leftCountryLabel.text ?? "")
        middleFavStack.accessibilityLabel = "Second favorite currency " + (middleCountryLabel.text ?? "")
        rightFavStack.accessibilityLabel = "Third favorite currency " + (rightCountryLabel.text ?? "")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCurrencies()
        setShadows()
        setupAccessibility()
        setFavoritesUI(currencies: [
            AppDelegate.shared().leftFavorite,
            AppDelegate.shared().middleFavorite,
            AppDelegate.shared().rightFavorite
        ])
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 120
        tableView.register(UINib(nibName: "CurrencyListCell", bundle: nil), forCellReuseIdentifier: "ReusableCurrencyListCell")
        
        navigationItem.searchController = searchController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        AppDelegate.shared().setSavedCurrencyValues()
        NotificationCenter.default.post(name: Notifications.publishNotification, object: nil, userInfo: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
    }
    
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension ChangeFavoritesViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() { return filteredCurrencies.count }
        return currencyArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let currentCurrency: Currency
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCurrencyListCell", for: indexPath) as? CurrencyListCell else { return UITableViewCell() }
        
        if isFiltering() {
            currentCurrency = filteredCurrencies[indexPath.row]
        } else {
            currentCurrency = currencyArray[indexPath.row]
        }

        cell.currencyCodeLabel.text = currentCurrency.currencyCode
        cell.currencyExpandedLabel.text = currentCurrency.currencyName
        cell.countryNameLabel.text = currentCurrency.countryName
        cell.flagImageView.image = UIImage(named: validateCode(currencyCode: currentCurrency.currencyCode))
        cell.containerView.layer.cornerRadius = 10
        
        cell.flagImageView.clipsToBounds = false
        cell.flagImageView.layer.shadowOpacity = 0.2
        cell.flagImageView.layer.shadowOffset = .zero
        cell.flagImageView.layer.shadowRadius = 5
        
        cell.backgroundColor = UIColor(named: "background")
        
        if currentCurrency.currencyCode == AppDelegate.shared().baseCurrency
            || currentCurrency.currencyCode == AppDelegate.shared().convertedCurrency {
            cell.isUserInteractionEnabled = false
            cell.addButtonImage.alpha = 0.3
            cell.countryNameLabel.alpha = 0.3
            cell.currencyCodeLabel.alpha = 0.3
            cell.currencyExpandedLabel.alpha = 0.3
            cell.flagImageView.alpha = 0.3
        } else {
            cell.isUserInteractionEnabled = true
            cell.addButtonImage.alpha = 1
            cell.countryNameLabel.alpha = 1
            cell.currencyCodeLabel.alpha = 1
            cell.currencyExpandedLabel.alpha = 1
            cell.flagImageView.alpha = 1
        }
        
        cell.isAccessibilityElement = true
        cell.accessibilityHint = "Double tap to add " + (cell.currencyCodeLabel.text ?? "") + " to your favorites"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath)
    {
        let cell = tableView.cellForRow(at: indexPath)

        UIView.animate(withDuration: 0.07) {

            cell!.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)
        }
    }

    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath)
    {
        let cell = tableView.cellForRow(at: indexPath)

        UIView.animate(withDuration: 0.1) {

            cell!.transform = .identity
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tappedCurrency: String
        
        let currentFavs = [
            AppDelegate.shared().leftFavorite,
            AppDelegate.shared().middleFavorite,
            AppDelegate.shared().rightFavorite
        ]
        
        if isFiltering() {
            tappedCurrency = filteredCurrencies[indexPath.row].currencyCode
        } else {
            tappedCurrency = currencyArray[indexPath.row].currencyCode
        }
        
        if AppDelegate.shared().baseCurrency == tappedCurrency || (AppDelegate.shared().convertedCurrency == tappedCurrency) {
            print("Tapped currency already in base or converted")
        } else if !(currentFavs.contains(tappedCurrency)){
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
        AppDelegate.shared().setSavedCurrencyValues()
        
        searchController.isActive = false
    }
}

extension ChangeFavoritesViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}
