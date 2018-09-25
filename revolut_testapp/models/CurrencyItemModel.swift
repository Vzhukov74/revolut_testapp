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
    private let initValue: Float
    private var baseCode: String?
    private var baseValue: Float?
    private(set) var isBase: Bool = false
    private(set) var value: Float
    
    var uiObserver: (() -> Void)?
    var baseValueObserver: ((_ newValue: Float) -> Void)?
    var currencyCode: String {
        return dataProvider.currencyCode
    }
    
    init(dataProvider: CurrencyDataProvider, initValue: Float) {
        self.initValue = initValue
        self.value = initValue
        self.dataProvider = dataProvider
        self.dataProvider.subscriber = { [weak self] in
            self?.calculate()
        }
        self.dataProvider.loadData()
    }
    
    func needToUpdateCurrencyData() {
        self.dataProvider.loadData()
    }
    
    private func calculate() {
        guard let baseValue = self.baseValue else { return }
        if isBase {
            value = baseValue
        } else {
            guard let baseCode = baseCode, let rate = dataProvider.data?.rates[baseCode] else { return }
            value = baseValue / rate
        }
        
        self.uiObserver?()
    }
    
    func didSetNew(baseCode: String) {
        self.isBase = baseCode == dataProvider.currencyCode

        if !self.isBase {
            self.baseCode = baseCode
        }
    }
    
    func didSetNew(baseValue: Float) {
        if !isBase {
            self.baseValue = baseValue
            calculate()
        }
    }
    
    func setNew(baseValue: Float) {
        self.baseValueObserver?(baseValue)
    }
}

extension CurrencyItemModel {
    var icon: String? {
        return AppConfig.currencyCodeToDetailInfoMapping[currencyCode]?.flag
    }
    
    var transcript: String? {
        return AppConfig.currencyCodeToDetailInfoMapping[currencyCode]?.name
    }
}
