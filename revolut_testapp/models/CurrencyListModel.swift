//
//  CurrencyListModel.swift
//  revolut_testapp
//
//  Created by Maximal Mac on 21.09.2018.
//  Copyright © 2018 vc. All rights reserved.
//

import Foundation

class CurrencyItemModel {
    let code: String
    private var task: NetworkTask<Currency>?
    private(set) var data: Currency?
    private var baseCode: String? {
        didSet {
            observer?()
        }
    }
    private var baseValue: Float? {
        didSet {
            observer?()
        }
    }
    
    var value: Float {
        if let baseValue = baseValue, let baseCode = baseCode, let rate = data?.rates[baseCode] {
            return baseValue / rate
        } else {
            return 0
        }
    }
    
    var isBase: Bool = false
    var observer: (() -> Void)?
    
    init(code: String) {
        self.code = code
        loadData()
    }
    
    private func loadData() {
        let url = ApiData.currencyDataBaseUrl + "/latest?base=" + code
        task = NetworkTask<Currency>()
        task?.execute(getUrl: url, completion: { (result) in
            switch result {
            case .success(let data):
                self.data = data
                self.observer?()
            case .fail(let error):
                print(error)
            }
        })
    }
    
    func didSetNew(baseCode: String) {
        self.baseCode = baseCode
    }
    
    func didSetNew(baseValue: Float) {
        self.baseValue = baseValue
    }
    
    deinit {
        print("deinit - CurrencyItemModel")
    }
}

class CurrencyListModel {
    private(set) var items: [CurrencyItemModel] = []
    private var currentBase: CurrencyItemModel {
        didSet {
            items.forEach { $0.didSetNew(baseCode: currentBase.code) }
        }
    }
    private var currentValue: Float {
        didSet {
            items.forEach { $0.didSetNew(baseValue: currentValue) }
        }
    }
    
    init(with currencyCodeList: [String]) {
        items = currencyCodeList.map { CurrencyItemModel(code: $0) }
        currentBase = items.first!
        currentValue = 1.0
        
        items.forEach { $0.didSetNew(baseCode: currentBase.code) }
        items.forEach { $0.didSetNew(baseValue: currentValue) }
    }
    
    func set(newBase: CurrencyItemModel) {
        currentBase.isBase = false
        newBase.isBase = true
        currentBase = newBase
    }
}
