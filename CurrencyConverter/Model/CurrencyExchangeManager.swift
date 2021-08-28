//
//  CurrencyExchangeManager.swift
//  CurrencyConverter
//
//  Created by Tim Neal on 3/27/21.
//  Copyright © 2021 Tim Neal. All rights reserved.
//

import Foundation

let currentDate = Date()
let formatter = DateFormatter()
var dateComponent = DateComponents()

struct CurrencyExchangeManager {
    func getExchangeRate() {
        let todayString: String
        let url: String
        
        formatter.dateFormat = "YYYY-MM-dd"
        todayString = formatter.string(from: currentDate)
        url = Constants.apiURL + todayString
        
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print("Error with session.dataTask: \(error!)")
                    dateComponent.day = -8
                    let pastDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)
                    print("Error with calling API, using default values")
                    UserDefaults.standard.setValue(pastDate, forKey: Constants.ratesLastUpdatedKey)
                    return
                }
                if let safeData = data {
                    let rates = self.parseJSON(safeData)
                    saveRates(rates: rates)
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> [String: Double] {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ExchangeRateData.self, from: data)
            let rates = decodedData.rates
            return rates
        } catch {
            print(error)
            return ["": 0.00]
        }
    }
    
    func saveRates(rates: [String: Double]) {
        UserDefaults.standard.setValue(rates, forKey: Constants.ratesDictionaryKey)
        print("Save rates completed")
    }
    
}
