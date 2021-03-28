//
//  CurrencyExchangeManager.swift
//  CurrencyConverter
//
//  Created by Tim Neal on 3/27/21.
//  Copyright © 2021 Tim Neal. All rights reserved.
//

import Foundation

struct CurrencyExchangeManager {
    
    let baseURL = "https://api.exchangeratesapi.io/latest?base="

    func getExchangeRate(for currency: String) {
        let urlString = "\(baseURL)\(currency)"
        print("URL: \(urlString)")

        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print("Error with session.dataTask: \(error!)")
                    return
                }
                
                let country = "EUR"
                
                if let safeData = data {
                    let rates = self.parseJSON(safeData)
                    let currentCountryRate = rates[country] ?? 0.0
                    let rateString = String(format: "%.2f", currentCountryRate)
                    print(rateString)
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
}
