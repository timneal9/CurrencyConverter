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

    var baseCurrency: String = "USD"
    var convertedCurrency: String = "EUR"
    var leftFavorite: String = "GBP"
    var middleFavorite: String = "CAD"
    var rightFavorite: String = "MXN"
    
    static func shared() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        baseCurrency = UserDefaults.standard.string(forKey: "baseCurrency") ?? "USD"
        convertedCurrency = UserDefaults.standard.string(forKey: "convertedCurrency") ?? "EUR"
        leftFavorite = UserDefaults.standard.string(forKey: "leftFavorite") ?? "GBP"
        middleFavorite = UserDefaults.standard.string(forKey: "middleFavorite") ?? "CAD"
        rightFavorite = UserDefaults.standard.string(forKey: "rightFavorite") ?? "MXN"
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        setSavedCurrencyValues()
        }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        setSavedCurrencyValues()
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        setSavedCurrencyValues()
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        setSavedCurrencyValues()
    }
    
    func setSavedCurrencyValues() {
        UserDefaults.standard.setValue(baseCurrency, forKey: "baseCurrency")
        UserDefaults.standard.setValue(convertedCurrency, forKey: "convertedCurrency")
        UserDefaults.standard.setValue(leftFavorite, forKey: "leftFavorite")
        UserDefaults.standard.setValue(middleFavorite, forKey: "middleFavorite")
        UserDefaults.standard.setValue(rightFavorite, forKey: "rightFavorite")
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

