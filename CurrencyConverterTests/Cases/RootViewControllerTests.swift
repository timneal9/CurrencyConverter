//
//  RootViewControllerTests.swift
//  CurrencyConverterTests
//
//  Created by Tim Neal on 10/5/21.
//  Copyright © 2021 Tim Neal. All rights reserved.
//

import XCTest
@testable import CurrencyConverter

class RootViewControllerTests: XCTestCase {
    var view: RootViewController!
    
    override func setUp() {
        super.setUp()
        view = RootViewController()
    }
    
    func testValidateCode() {
        let code = "AUD"
        let validatedCode = view.validateCode(currencyCode: code)
        XCTAssertEqual(validatedCode, code)
        
        let errorCode = "ZZZ"
        let validatedErrorCode = view.validateCode(currencyCode: errorCode)
        XCTAssertEqual(validatedErrorCode, "ERR")
    }
    
//    func testNumButtonTapped() {
//        view.baseAmount = "0.00"
//        view.decimalActive = true
//        view.decimalActiveCount = 0
//        view.numButtonTapped(num: "1")
//        XCTAssertEqual(view.decimalString, ".00")
//    }
    
    func testFetchImage() {
        let code = "AUD"
        let fetchedImage = view.fetchImage(currencyCode: code)
        XCTAssertEqual(UIImage(named: code), fetchedImage)
        
        let errorCode = "ZZZ"
        let fetchedError = view.fetchImage(currencyCode: errorCode)
        XCTAssertEqual(UIImage(named: "ERR"), fetchedError)
    }
    
    func testCheckDecimalCount() {
        view.decimalActiveCount = 1
        view.checkDecimalCount()
        XCTAssertEqual(view.decimalActiveCount, 1)
        
        view.decimalActiveCount = 2
        view.checkDecimalCount()
        XCTAssertEqual(view.decimalActiveCount, 0)
    }
    
    func testIsPremiumUser() {
        UserDefaults.standard.setValue("true", forKey: Constants.premiumUserKey)
        XCTAssertTrue(view.isPremiumUser())
        
        UserDefaults.standard.setValue("false", forKey: Constants.premiumUserKey)
        XCTAssertFalse(view.isPremiumUser())
    }
    
}
