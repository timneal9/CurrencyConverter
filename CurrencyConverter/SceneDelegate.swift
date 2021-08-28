//
//  SceneDelegate.swift
//  CurrencyConverter
//
//  Created by Tim Neal on 3/25/21.
//  Copyright © 2021 Tim Neal. All rights reserved.
//

import UIKit
import StoreKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    let defaults = UserDefaults.standard
    let currencyExchangeManager = CurrencyExchangeManager()
    var window: UIWindow?
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        let today = Date()
        let diffInDays: Int
        let formatter = DateFormatter()
        let premiumUser = defaults.bool(forKey: Constants.premiumUserKey)
        let defaultRatesSet = defaults.bool(forKey: Constants.defaultRatesSetKey)
        let premiumUserSettingsString = premiumUser ? "Yes" : "No"
        let maxDays = premiumUser ? 1 : 7
        let ratesLastUpdatedString: String
        var lastCalledDate: Date
        
        // First launch actions
        if !defaultRatesSet {
            setDefaultRates()
            defaults.setValue(true, forKey: Constants.defaultRatesSetKey)
            callAPI()
        }
        
        if (defaults.object(forKey: Constants.ratesLastUpdatedKey) != nil) {
            lastCalledDate = (defaults.object(forKey: Constants.ratesLastUpdatedKey) as! Date)
        } else {
            setDefaultRates()
            callAPI()
        }
        
        lastCalledDate = (defaults.object(forKey: Constants.ratesLastUpdatedKey) as! Date)
        diffInDays = Calendar.current.dateComponents([.day], from: lastCalledDate, to: today).day ?? 0
        formatter.dateFormat = "h:mm a, M/d/y"
        ratesLastUpdatedString = formatter.string(from: lastCalledDate)
        
        UserDefaults.standard.setValue(ratesLastUpdatedString, forKey: Constants.ratesLastUpdatedStringKey)
        UserDefaults.standard.setValue(premiumUserSettingsString, forKey: Constants.premiumUserSettingsStringKey)
        
        if diffInDays >= maxDays {
            callAPI()
        }
        requestReviews()
    }
    
    func callAPI() {
        currencyExchangeManager.getExchangeRate()
        defaults.setValue(Date(), forKey: Constants.ratesLastUpdatedKey)
    }
    
    func requestReviews() {
        var counter = defaults.integer(forKey: Constants.launchCounterKey)
        if ((counter % 10) == 0) {
            SKStoreReviewController.requestReview()
            counter = 1
        } else {
            counter += 1
        }
        defaults.setValue(counter, forKey: Constants.launchCounterKey)
    }
    
    func setDefaultRates() {
        let defaultRates = ["NAD": 16.89293, "ERN": 17.63949, "ISK": 147.73244, "PEN": 4.807593, "ANG": 2.110142, "SCR": 16.915188, "SBD": 9.466044, "GNF": 11508.351, "NIO": 41.427074, "XPF": 119.258965, "AZN": 2.000395, "CDF": 2342.8538, "DKK": 7.434355, "AFN": 94.17225, "HUF": 353.72583, "BRL": 6.15936, "MWK": 959.06104, "BTN": 87.4454, "QAR": 4.296224, "UYU": 51.57278, "RWF": 1188.8208, "AED": 4.318619, "PHP": 59.538567, "MZN": 74.82462, "DOP": 67.35226, "SSP": 153.12814, "VND": 27052.361, "CVE": 109.76761, "MVR": 18.174103, "CUP": 30.270924, "LAK": 11279.882, "DZD": 159.10545, "ZWL": 378.52966, "CAD": 1.476252, "NOK": 10.448341, "KRW": 1347.3545, "ARS": 113.89307, "GTQ": 9.111217, "TOP": 2.649223, "FKP": 0.847601, "JPY": 129.56456, "JEP": 0.848107, "KYD": 0.979973, "PKR": 193.68509, "MYR": 4.960366, "NGN": 483.71884, "TWD": 32.706043, "TJS": 13.407577, "OMR": 0.453007, "MMK": 1934.9048, "EGP": 18.461983, "CNY": 7.622497, "SDG": 524.88696, "BMD": 1.17602, "UGX": 4170.447, "SEK": 10.192367, "LSL": 17.124443, "MRU": 42.624, "VES": 4726781.5, "PGK": 4.142694, "KMF": 489.09033, "UZS": 12526.709, "JOD": 0.833769, "BBD": 2.352254, "KPW": 1058.0022, "LBP": 1784.0024, "SZL": 17.124424, "IDR": 16919.38, "SOS": 682.4801, "GGP": 0.84824, "MAD": 10.559661, "STN": 24.628796, "GEL": 3.627225, "TZS": 2735.838, "LYD": 5.303179, "EUR": 1.0, "AUD": 1.598742, "THB": 39.288284, "GYD": 246.59933, "FJD": 2.438066, "AWG": 2.117287, "COP": 4622.258, "MUR": 50.658413, "XAG": 0.048688, "LRD": 201.75523, "SRD": 25.192429, "CLP": 926.6333, "KZT": 501.16193, "CNH": 7.616161, "RUB": 85.89277, "AOA": 750.66565, "SYP": 1478.328, "YER": 293.8898, "LKR": 234.51663, "BTC": 2.7e-05, "XPT": 0.001834, "IMP": 0.847701, "BSD": 1.175537, "CLF": 0.034576, "HNL": 28.010445, "PLN": 4.572804, "XAU": 0.001153, "STD": 24293.195, "GBP": 0.847631, "RON": 4.911929, "BOB": 8.117142, "KHR": 4808.6265, "XDR": 0.825189, "CRC": 728.88965, "AMD": 581.43335, "MXN": 23.564114, "GMD": 60.1306, "INR": 87.23846, "HTG": 113.84588, "TTD": 8.001276, "IRR": 49555.625, "RSD": 117.056725, "TRY": 10.143507, "DJF": 210.02097, "BYN": 2.964718, "UAH": 31.642143, "BDT": 99.90099, "ETB": 53.012238, "ILS": 3.791865, "KWD": 0.354514, "NZD": 1.677081, "PAB": 1.175457, "HKD": 9.146148, "NPR": 139.9128, "SHP": 0.847827, "BZD": 2.370465, "BGN": 1.955213, "HRK": 7.494504, "TMT": 4.115202, "KES": 127.90128, "ALL": 121.36579, "XAF": 655.5548, "WST": 3.007831, "USD": 1.175938, "SGD": 1.592431, "BAM": 1.947969, "KGS": 99.61692, "CUC": 1.176195, "BIF": 2338.8435, "GHS": 7.079235, "BHD": 0.443197, "XOF": 655.5548, "TND": 3.264104, "SLL": 12052.987, "VUV": 130.05379, "MOP": 9.417016, "MNT": 3350.3054, "SAR": 4.40858, "SVC": 10.286154, "ZAR": 17.204166, "JMD": 182.17682, "MRO": 419.6742, "CHF": 1.075467, "IQD": 1721.2574, "ZMW": 22.652653, "MKD": 61.577908, "GIP": 0.848361, "MDL": 21.058798, "BWP": 12.960849, "XPD": 0.000678, "XCD": 3.177902, "CZK": 25.39468, "BND": 1.588449, "PYG": 8176.164, "MGA": 4606.9326]
        defaults.setValue(defaultRates, forKey: Constants.ratesDictionaryKey)
    }
}
