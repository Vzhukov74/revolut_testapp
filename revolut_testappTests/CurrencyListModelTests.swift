//
//  CurrencyListModelTests.swift
//  revolut_testappTests
//
//  Created by Maximal Mac on 25.09.2018.
//  Copyright © 2018 vc. All rights reserved.
//

import XCTest
@testable import revolut_testapp

class CurrencyListModelTests: XCTestCase {

    var currencyList = ["USD", "RUB", "EUR"]
    var rates: [String: [String: Float]] = [
        "USD": ["RUB": 1, "EUR": 2],
        "RUB": ["USD": 3, "EUR": 4],
        "EUR": ["RUB": 5, "USD": 6]
    ]

    // MARK: tests
    
    //#1
    //checks that CurrencyListModel do init properly
    func testInit() {
        let dataProviders = currencyList.map { CurrencyDataProvider_mock(currencyCode: $0) }
        dataProviders.forEach { $0._data = Currency(base: $0.currencyCode, date: "", rates: rates[$0.currencyCode]!) }
        let items = dataProviders.map { CurrencyItemModel_mock(dataProvider: $0, initValue: 1) }

        _ = CurrencyListModel(with: items)
        
        items.forEach { (item) in
            XCTAssertTrue(item.baseValueObserver != nil, "CurrencyListModel didt set baseValueObserver")
            XCTAssertTrue(item.didSetNewBaseBaseValue != nil, "CurrencyListModel didt set baseValue")
            XCTAssertTrue(item.didSetNewBaseCodeValue != nil, "CurrencyListModel didt set codeValue")
            
            XCTAssertEqual(item.didSetNewBaseBaseValueCount, 1, "CurrencyListModel set baseValue more that one time")
            XCTAssertEqual(item.didSetNewBaseCodeValueCount, 1, "CurrencyListModel set codeValue more that one time")
            
            XCTAssertEqual(item.didSetNewBaseBaseValue ?? 0, 1, "CurrencyListModel didt set correct baseValue")
            XCTAssertEqual(item.didSetNewBaseCodeValue ?? "", "USD", "CurrencyListModel didt set correct codeValue")
        }
    }

    //#2
    //checks that CurrencyListModel do swaps for currency properly
    func testThatModelDOSwapItemProperly() {
        let dataProviders = currencyList.map { CurrencyDataProvider_mock(currencyCode: $0) }
        dataProviders.forEach { $0._data = Currency(base: $0.currencyCode, date: "", rates: rates[$0.currencyCode]!) }
        let items = dataProviders.map { CurrencyItemModel_mock(dataProvider: $0, initValue: 1) }
        
        let model = CurrencyListModel(with: items)
       
        //reset counters after init
        items.forEach {
            $0.didSetNewBaseBaseValueCount = 0
            $0.didSetNewBaseCodeValueCount = 0
        }
        
        //first set invalid index for swap
        model.swapItem(at: 10, to: 0)
        items.forEach { (item) in
            XCTAssertEqual(item.didSetNewBaseBaseValueCount, 0, "CurrencyListModel set baseValue")
            XCTAssertEqual(item.didSetNewBaseCodeValueCount, 0, "CurrencyListModel set codeValue")
        }
        
        //second set valid index for swap
        //counters will be 0!
        let swapIndex = 2
        let newBaseValue = items[swapIndex].value
        let newBaseCode = items[swapIndex].currencyCode
        model.swapItem(at: 0, to: swapIndex)
        items.forEach { (item) in
            XCTAssertEqual(item.didSetNewBaseBaseValueCount, 1, "CurrencyListModel didt set baseValue")
            XCTAssertEqual(item.didSetNewBaseCodeValueCount, 1, "CurrencyListModel didt set codeValue")
            
            XCTAssertEqual(item.didSetNewBaseBaseValue ?? 0, newBaseValue, "CurrencyListModel didt set correct baseValue")
            XCTAssertEqual(item.didSetNewBaseCodeValue ?? "", newBaseCode, "CurrencyListModel didt set correct baseValue")
        }
    }
    
    //#3
    //checks that CurrencyListModel update data every sec
    func testThatModelUpdatesDataEverySecond() {
        let dataProviders = currencyList.map { CurrencyDataProvider_mock(currencyCode: $0) }
        dataProviders.forEach { $0._data = Currency(base: $0.currencyCode, date: "", rates: rates[$0.currencyCode]!) }
        let items = dataProviders.map { CurrencyItemModel_mock(dataProvider: $0, initValue: 1) }
        items[0].needToUpdateCurrencyDataPromise = XCTestExpectation(description: "CurrencyListModel did update data after sec")
        
        let model = CurrencyListModel(with: items)
        model.swapItem(at: 10, to: 10) //for resolve warning about unused model value
        
        wait(for: [items[0].needToUpdateCurrencyDataPromise!], timeout: 1.5)
    }
}
