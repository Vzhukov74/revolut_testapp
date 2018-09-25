//
//  CurrencyItemModel.swift
//  revolut_testapp
//
//  Created by Maximal Mac on 24.09.2018.
//  Copyright © 2018 vc. All rights reserved.
//

import Foundation

class CurrencyItemModel {
    private let dataProvider: CurrencyDataProvider!
    private var baseCode: String? {
        didSet {
            uiObserver?()
        }
    }
    private var baseValue: Float? {
        didSet {
            uiObserver?()
        }
    }
    
    var currencyCode: String {
        return dataProvider.currencyCode
    }

    var value: Float {
        if let baseValue = baseValue, let baseCode = baseCode, let rate = dataProvider.data?.rates[baseCode] {
            return baseValue / rate
        } else {
            return baseValue ?? AppConfig.currencyInitBaseValue //if baseValue is nil return init value
        }
    }
    
    private(set) var isBase: Bool = false
    var uiObserver: (() -> Void)?
    var baseValueObserver: ((_ newValue: Float) -> Void)?
    
    init(dataProvider: CurrencyDataProvider) {
        self.dataProvider = dataProvider
        self.dataProvider.subscriber = { [weak self] in
            self?.uiObserver?()
        }
        self.dataProvider.loadData()
    }
    
    func needToUpdateCurrencyData() {
        self.dataProvider.loadData()
    }
    
    func didSetNew(baseCode: String) {
        self.isBase = baseCode == dataProvider.currencyCode ? true : false
        self.baseCode = baseCode
    }
    
    func didSetNew(baseValue: Float) {
        if !isBase {
            self.baseValue = baseValue
        }
    }
    
    func setNew(baseValue: Float) {
        self.baseValue = baseValue
        self.baseValueObserver?(baseValue)
    }
}
