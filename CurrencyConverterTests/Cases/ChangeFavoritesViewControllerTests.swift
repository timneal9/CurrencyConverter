//
//  ChangeFavoritesViewControllerTests.swift
//  CurrencyConverterTests
//
//  Created by Tim Neal on 10/5/21.
//  Copyright © 2021 Tim Neal. All rights reserved.
//

import XCTest
@testable import CurrencyConverter

class ChangeFavoritesViewControllerTests: XCTestCase {
    var view: ChangeFavoritesViewController!
    
    override func setUp() {
        super.setUp()
        view = ChangeFavoritesViewController()
    }
    
    func testValidateCode() {
        let code = "AUD"
        let validatedCode = view.validateCode(currencyCode: code)
        XCTAssertEqual(validatedCode, code)
        
        let errorCode = "ZZZ"
        let validatedErrorCode = view.validateCode(currencyCode: errorCode)
        XCTAssertEqual(validatedErrorCode, "ERR")
    }
    

}
