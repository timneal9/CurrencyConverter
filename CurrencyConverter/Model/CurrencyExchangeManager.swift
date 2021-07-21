//
//  CurrencyExchangeManager.swift
//  CurrencyConverter
//
//  Created by Tim Neal on 3/27/21.
//  Copyright © 2021 Tim Neal. All rights reserved.
//

import Foundation

struct CurrencyExchangeManager {
    
    let baseURL = "https://api.exchangerate.host/latest"
    
    func getExchangeRate() {
        
        if let url = URL(string: baseURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print("Error with session.dataTask: \(error!)")
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
    
    func parseJSON(_ data: Data) -> [String: Float] {
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
    
    func saveRates(rates: [String: Float]) {
        UserDefaults.standard.setValue(rates, forKey: "ratesDictionary")
    }
    
}
