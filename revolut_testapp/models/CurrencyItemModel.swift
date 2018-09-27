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
    private(set) var value: Float
    
    var isBase: Bool {
        return ((baseCode ?? "") == dataProvider.currencyCode)
    }
    
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
        if !isBase {
            guard let baseCode = baseCode, let rate = dataProvider.data?.rates[baseCode] else { return }
            value = baseValue / rate
        }
        
        self.uiObserver?()
    }
    
    func didSetNew(baseCode: String) {
        self.baseCode = baseCode
    }
    
    func didSetNew(baseValue: Float) {
        self.baseValue = baseValue
        calculate()
    }
    
    func setNew(baseValue: Float) {
        guard isBase else { return }
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
