//
//  Constants.swift
//  CurrencyConverter
//
//  Created by Tim Neal on 8/12/21.
//  Copyright © 2021 Tim Neal. All rights reserved.
//

struct Constants {
    // Identifiers, Nibs, etc
    static let CAROUSEL_ITEM_NIB = "CarouselItem"
    static let currencyListCellNib = "CurrencyListCell"
    static let cellReuseIdentifier = "ReusableCurrencyListCell"
    static let notificationName = "VCPublishEvent"
    static let premiumProductID = "com.timnealdev.CurrencyConverter.Premium"
    
    // API
    static let apiURL = "https://api.exchangerate.host/latest"
    
    // Segues
    static let homeToChangeSegue = "HomeToChange"
    static let homeToPurchasePremiumSegue = "HomeToPurchasePremium"
    
    // UserDefaults
    static let ratesLastUpdatedKey = "ratesLastUpdated"
    static let ratesDictionaryKey = "ratesDictionary"
    static let premiumUserKey = "premiumUser"
    static let previouslyLaunched = "previouslyLaunched"
    
    // Colors
    static let lightMumfordIndigo = "mumfordIndigo"
    static let darkJupiterIndigo = "jupiterIndigo"
    static let backgroundColor = "background"
    
    // Text Labels
    static let carouselPage1Title = "Where will you go?"
    static let carouselPage2Title = "Save Favorites"
    static let carouselPage3Title = "Premium Features"
    
    static let carouselPage1SubTitle = "Take over 150 currencies with you!"
    static let carouselPage2SubTitle = "Search and save your top 3 currencies"
    static let carouselPage3SubTitle = "Upgrade now to unlock!"
    static let searchBarPlaceholder = "Search Currencies"
    
    static let noInternetAlertTitle = "No Internet Connection"
    static let noInternetAlertPurchaseMessage = "Internet connection is required to make purchases. Please connect to internet and try again."
    static let noInternetAlertRestorePurchaseMessage = "Internet connection is required to restore purchases. Please connect to internet and try again."
    static let purchaseSuccessfulTitle = "Purchse successful!"
    static let purchaseSuccessfulMessage = "Premium features are now unlocked. Enjoy!"
    static let restoreSuccessfulTitle = "Restore successful!"
    static let restoreSuccessfulMessage = "Welcome back, enjoy!"
    static let failedPurchaseTitle = "Uh oh"
    static let failedPurchsaeMessage = "Something went wrong during purchasing. Please try again."
    static let okButton = "OK"
    
    // Images
    static let carouselPage1Image = "premiumPage1"
    static let carouselPage2Image = "premiumPage2"
    static let carouselPage3Image = "premiumPage3"
}
