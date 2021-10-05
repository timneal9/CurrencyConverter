//
//  CurrenciesTests.swift
//  CurrencyConverterTests
//
//  Created by Tim Neal on 10/5/21.
//  Copyright © 2021 Tim Neal. All rights reserved.
//

import XCTest
@testable import CurrencyConverter

class CurrenciesTests: XCTestCase {
    var view: Currencies!
    
    override func setUp() {
        super.setUp()
        view = Currencies()
    }

    func testCurrencies() {
        let count = view.currencyObjects.count
        XCTAssertEqual(count, 153)
    }
}
