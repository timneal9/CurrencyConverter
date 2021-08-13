//
//  CurrencyExchangeManager.swift
//  CurrencyConverter
//
//  Created by Tim Neal on 3/27/21.
//  Copyright © 2021 Tim Neal. All rights reserved.
//

import Foundation

struct CurrencyExchangeManager {

    func getExchangeRate() {
        
        if let url = URL(string: Constants.apiURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print("Error with session.dataTask: \(error!)")
                    
                    let currentDate = Date()
                    var dateComponent = DateComponents()
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
