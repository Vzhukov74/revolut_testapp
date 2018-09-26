//
//  CurrencyItemModel_mock.swift
//  revolut_testappTests
//
//  Created by Maximal Mac on 26.09.2018.
//  Copyright © 2018 vc. All rights reserved.
//

import XCTest
@testable import revolut_testapp

class CurrencyItemModel_mock: CurrencyItemModel {
    
    var didSetNewBaseCodeValue: String?
    var didSetNewBaseBaseValue: Float?
    var didSetNewBaseCodeValueCount = 0
    var didSetNewBaseBaseValueCount = 0
    var needToUpdateCurrencyDataCount = 0
    var needToUpdateCurrencyDataPromise: XCTestExpectation?
    
    override func didSetNew(baseCode: String) {
        didSetNewBaseCodeValue = baseCode
        didSetNewBaseCodeValueCount += 1
    }
    
    override func didSetNew(baseValue: Float) {
        didSetNewBaseBaseValue = baseValue
        didSetNewBaseBaseValueCount += 1
    }
    
    override func needToUpdateCurrencyData() {
        needToUpdateCurrencyDataPromise?.fulfill()
    }
}
