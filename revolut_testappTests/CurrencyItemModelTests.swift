//
//  CurrencyItemModelTests.swift
//  revolut_testappTests
//
//  Created by Maximal Mac on 26.09.2018.
//  Copyright © 2018 vc. All rights reserved.
//

import XCTest
@testable import revolut_testapp

class CurrencyItemModelTests: XCTestCase {

    var rates: [String: Float] = ["RUB": 10, "EUR": 2]
    let base = "USD"
    
    // MARK: tests
    
    //#1
    //checks that CurrencyItemModel calculate courses correctly
    func testCalculation() {
        let dataProvider = CurrencyDataProvider_mock(currencyCode: base)
        dataProvider._data = Currency(base: base, date: "", rates: rates)
        let item = CurrencyItemModel(dataProvider: dataProvider, initValue: 1)
        item.didSetNew(baseCode: "RUB")
        item.didSetNew(baseValue: 5)
        
        XCTAssertEqual(item.value, 0.5, "CurrencyItemModel didt correct calculate value")
        
        //set item as base
        item.didSetNew(baseCode: "USD")
        item.didSetNew(baseValue: 50) //if item is base, then set new value didt calculate value
        XCTAssertEqual(item.value, 0.5, "CurrencyItemModel didt correct calculate value")
    }
    
    //#2
    //checks that CurrencyItemModel correct set value isBase when baseCode did changed
    func testDidSetNewBaseCode() {
        let dataProvider = CurrencyDataProvider_mock(currencyCode: base)
        dataProvider._data = Currency(base: base, date: "", rates: rates)
        let item = CurrencyItemModel(dataProvider: dataProvider, initValue: 1)
        
        XCTAssertFalse(item.isBase, "value isBase did set uncorrect")
        
        item.didSetNew(baseCode: base)
        XCTAssertTrue(item.isBase, "value isBase did set uncorrect")
    }
    
    //#3
    //checks that CurrencyItemModel calls loadData() from dataProvider when get call of needToUpdateCurrencyData()
    func testNeedToUpdateCurrencyData() {
        let dataProvider = CurrencyDataProvider_mock(currencyCode: base)
        dataProvider._data = Currency(base: base, date: "", rates: rates)
        let item = CurrencyItemModel(dataProvider: dataProvider, initValue: 1)
        
        //we call loadData in init
        XCTAssertEqual(dataProvider.loadDataCounter, 1, "CurrencyItemModel didt calls loadData")
        
        dataProvider.loadDataCounter = 0
        item.needToUpdateCurrencyData()
        XCTAssertEqual(dataProvider.loadDataCounter, 1, "CurrencyItemModel didt calls loadData")
    }
    
    //#4
    //checks that CurrencyItemModel calls baseValueObserver with correct value when value did updated
    func testBaseValueObserver() {
        var baseValueObserverCount = 0
        var correctValueForBaseValueObserver: Float = 0
        
        let dataProvider = CurrencyDataProvider_mock(currencyCode: base)
        dataProvider._data = Currency(base: base, date: "", rates: rates)
        let item = CurrencyItemModel(dataProvider: dataProvider, initValue: 1)
        item.baseValueObserver = { (value) in
            baseValueObserverCount += 1
            XCTAssertEqual(value, correctValueForBaseValueObserver, "CurrencyItemModel calls baseValueObserver with uncorrect value")
        }
        
        XCTAssertEqual(baseValueObserverCount, 0, "CurrencyItemModel calls baseValueObserver")
        
        //with correct value, but item is not base
        correctValueForBaseValueObserver = 10
        item.setNew(baseValue: correctValueForBaseValueObserver)
        XCTAssertEqual(baseValueObserverCount, 0, "CurrencyItemModel didt calls baseValueObserver")
        
        correctValueForBaseValueObserver = 15
        item.didSetNew(baseCode: item.currencyCode)
        item.setNew(baseValue: correctValueForBaseValueObserver)
        XCTAssertEqual(baseValueObserverCount, 1, "CurrencyItemModel didt calls baseValueObserver")
    }
    
    //#4
    //checks that CurrencyItemModel calls uiObserver when value did updated
    func testUIObserver() {
        var uiObserverCount = 0
        let dataProvider = CurrencyDataProvider_mock(currencyCode: base)
        dataProvider._data = Currency(base: base, date: "", rates: rates)
        let item = CurrencyItemModel(dataProvider: dataProvider, initValue: 1)
        
        item.uiObserver = {
            uiObserverCount += 1
        }
        XCTAssertEqual(uiObserverCount, 0, "CurrencyItemModel calls uiObserver")
        
        item.didSetNew(baseCode: "RUB")
        item.didSetNew(baseValue: 10)
        XCTAssertEqual(uiObserverCount, 1, "CurrencyItemModel didt calls uiObserver")
    }
}
