//
//  AppDelegate.swift
//  CurrencyConverter
//
//  Created by Tim Neal on 3/25/21.
//  Copyright © 2021 Tim Neal. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let defaults = UserDefaults.standard
    let currencyExchangeManager = CurrencyExchangeManager()
    var baseCurrency:       String = "USD"
    var convertedCurrency:  String = "EUR"
    var leftFavorite:       String = "GBP"
    var middleFavorite:     String = "CAD"
    var rightFavorite:      String = "MXN"
    
    static func shared() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        baseCurrency        = defaults.string(forKey: "baseCurrency") ?? "USD"
        convertedCurrency   = defaults.string(forKey: "convertedCurrency") ?? "EUR"
        leftFavorite        = defaults.string(forKey: "leftFavorite") ?? "GBP"
        middleFavorite      = defaults.string(forKey: "middleFavorite") ?? "CAD"
        rightFavorite       = defaults.string(forKey: "rightFavorite") ?? "MXN"
        
        let today = Date()
        var lastCalledDate: Date
        
        if (defaults.object(forKey: "ratesLastUpdated") != nil) {
            lastCalledDate = (defaults.object(forKey: "ratesLastUpdated") as! Date)
            print("API was last called on: \(lastCalledDate)")
        } else {
            print("ratesLastUpdated returned as nil. Calling API...")
            lastCalledDate = today
            defaults.setValue(lastCalledDate, forKey: "ratesLastUpdated")
            
            callAPI()
        }
        
        let diffInDays = Calendar.current.dateComponents([.day], from: lastCalledDate, to: today).day ?? 0
        
        // If more than x days since last API call, call API
        let premiumUser = true
        let maxDays: Int
        if premiumUser {
            maxDays = 1
        } else {
            maxDays = 7
        }
        if diffInDays > maxDays {
            lastCalledDate = today
            defaults.setValue(lastCalledDate, forKey: "ratesLastUpdated")
            
            print("API was last called more than \(maxDays) days ago. Calling API...")
            
            callAPI()
        }
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        setSavedCurrencyValues()
        }
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        setSavedCurrencyValues()
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func callAPI() {
        currencyExchangeManager.getExchangeRate()
    }
    
    func setSavedCurrencyValues() {
        defaults.setValue(baseCurrency, forKey:         "baseCurrency")
        defaults.setValue(convertedCurrency, forKey:    "convertedCurrency")
        defaults.setValue(leftFavorite, forKey:         "leftFavorite")
        defaults.setValue(middleFavorite, forKey:       "middleFavorite")
        defaults.setValue(rightFavorite, forKey:        "rightFavorite")
    }

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CurrencyDataModel")
        print(container.persistentStoreDescriptions.first?.url ?? "url unknown")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
//     MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
        } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

