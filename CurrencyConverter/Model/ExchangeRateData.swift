//
//  ExchangeRateData.swift
//  CurrencyConverter
//
//  Created by Tim Neal on 3/27/21.
//  Copyright © 2021 Tim Neal. All rights reserved.
//

import Foundation

struct ExchangeRateData: Codable {
    let rates: [String: Double]
}
