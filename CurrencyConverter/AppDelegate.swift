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

//    static func shared() -> AppDelegate {
//        return UIApplication.shared.delegate as! AppDelegate
//    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        let container = NSPersistentContainer(name: "CurrencyDataModel")
//        print(container.persistentStoreDescriptions.first?.url)
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {

        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }

//    lazy var persistentContainer: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "CurrencyDataModel")
//        print(container.persistentStoreDescriptions.first?.url)
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        return container
//    }()
    
    // MARK: - Core Data Saving support
    
//    func saveContext () {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//        } catch {
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }
}

