//
//  CurrencyExchangeManager.swift
//  CurrencyConverter
//
//  Created by Tim Neal on 3/27/21.
//  Copyright © 2021 Tim Neal. All rights reserved.
//

import Foundation

//func didUpdateRates(selectedCountry: String, rates: [String: Float]) {
//    var ratesCache: [String: [String: Float]] = [:]
//    ratesCache[selectedCountry] = rates
//    print(ratesCache)
//    print(ratesCache["USD"]?["EUR"] ?? 0.00)
//}

struct CurrencyExchangeManager {
    
    let baseURL = "https://api.exchangeratesapi.io/latest?base="
    
    func getExchangeRate(for country: String) {
        let urlString = "\(baseURL)\(country)"
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print("Error with session.dataTask: \(error!)")
                    return
                }
                if let safeData = data {
                    let rates = self.parseJSON(safeData)
//                    print(rates)
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
