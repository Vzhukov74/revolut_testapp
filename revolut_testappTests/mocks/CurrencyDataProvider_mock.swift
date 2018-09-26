//
//  CurrencyDataProvider_mock.swift
//  revolut_testappTests
//
//  Created by Maximal Mac on 26.09.2018.
//  Copyright © 2018 vc. All rights reserved.
//

import Foundation
@testable import revolut_testapp

class CurrencyDataProvider_mock: CurrencyDataProvider {
    
    override var data: Currency? {
        return _data
    }
    
    var _data: Currency?
    
    var loadDataCounter: Int = 0
    
    override func loadData() {
        loadDataCounter += 1
    }
}
