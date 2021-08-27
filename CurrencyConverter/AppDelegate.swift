//
//  AppDelegate.swift
//  CurrencyConverter
//
//  Created by Tim Neal on 3/25/21.
//  Copyright © 2021 Tim Neal. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    let defaults = UserDefaults.standard
    var baseCurrency:       String = "USD"
    var convertedCurrency:  String = "EUR"
    var leftFavorite:       String = "GBP"
    var middleFavorite:     String = "CAD"
    var rightFavorite:      String = "MXN"
    
    static func shared() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        baseCurrency = defaults.string(forKey: "baseCurrency") ?? "USD"
        convertedCurrency = defaults.string(forKey: "convertedCurrency") ?? "EUR"
        leftFavorite = defaults.string(forKey: "leftFavorite") ?? "GBP"
        middleFavorite = defaults.string(forKey: "middleFavorite") ?? "CAD"
        rightFavorite = defaults.string(forKey: "rightFavorite") ?? "MXN"
        
        let previouslyLaunched = defaults.bool(forKey: Constants.previouslyLaunched)
        
        if !previouslyLaunched {
            defaults.set(true, forKey: Constants.previouslyLaunched)
            defaults.setValue(1, forKey: Constants.launchCounterKey)
        }
        
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor = UIColor(named: "background")
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor(named: "text") ?? .tertiaryLabel]
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        
        UserDefaults.standard.setValue(UIApplication.appVersion ?? "", forKey: Constants.appVersionKey)
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        setSavedCurrencyValues()
    }
    
    func setSavedCurrencyValues() {
        defaults.setValue(baseCurrency, forKey:         "baseCurrency")
        defaults.setValue(convertedCurrency, forKey:    "convertedCurrency")
        defaults.setValue(leftFavorite, forKey:         "leftFavorite")
        defaults.setValue(middleFavorite, forKey:       "middleFavorite")
        defaults.setValue(rightFavorite, forKey:        "rightFavorite")
    }
    
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        setSavedCurrencyValues()
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}

extension UIApplication {
    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
}

