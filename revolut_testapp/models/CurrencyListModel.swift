//
//  CurrencyListModel.swift
//  revolut_testapp
//
//  Created by Maximal Mac on 21.09.2018.
//  Copyright © 2018 vc. All rights reserved.
//

import Foundation

class CurrencyListModel {
    private(set) var items: [CurrencyItemModel] = []
    private var currentBase: String {
        didSet {
            items.forEach { $0.didSetNew(baseCode: currentBase) }
        }
    }
    private var currentValue: Float {
        didSet {
            items.forEach { $0.didSetNew(baseValue: currentValue) }
        }
    }
    private var timer = Timer()
    
    init(with currencyItems: [CurrencyItemModel]) {
        assert(currencyItems.count > 0)
        items = currencyItems
        currentBase = items.first!.currencyCode //we always have first element in items
        currentValue = AppConfig.currencyInitBaseValue
        
        items.forEach { $0.didSetNew(baseCode: currentBase) }
        items.forEach { $0.didSetNew(baseValue: currentValue) }
        items.forEach {
            $0.baseValueObserver = { [weak self] (value) in
                self?.currentValue = value
            }
        }
        
        let timeInterval = TimeInterval(AppConfig.currencyUpdateTimeInterval)
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true, block: { [weak self] (_) in
            self?.needToUpdateCurrencyData()
        })
    }
    
    func swapItem(at i: Int, to j: Int) {
        guard i < items.count else { return }
        items.swapAt(i, j)
        let base = items.first! //we always have first element in items
        set(newBase: base)
    }
    
    private func set(newBase: CurrencyItemModel) {
        let value = newBase.value
        currentBase = newBase.currencyCode
        currentValue = value
    }

    private func needToUpdateCurrencyData() {
        items.forEach { $0.needToUpdateCurrencyData() }
    }
    
    deinit {
        timer.invalidate()
    }
}
