//
//  CurrencyItemModel.swift
//  revolut_testapp
//
//  Created by Maximal Mac on 24.09.2018.
//  Copyright © 2018 vc. All rights reserved.
//

import Foundation

class CurrencyItemModel {
    let code: String
    private var task: NetworkTask<Currency>?
    private(set) var data: Currency?
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
    
    var value: Float {
        if let baseValue = baseValue, let baseCode = baseCode, let rate = data?.rates[baseCode] {
            return baseValue / rate
        } else {
            return 1
        }
    }
    
    private(set) var isBase: Bool = false
    var uiObserver: (() -> Void)?
    var baseValueObserver: ((_ newValue: Float) -> Void)?
    
    init(code: String) {
        self.code = code
        loadData()
    }
    
    func needToUpdateCurrencyData() {
        loadData()
    }
    
    func didSetNew(baseCode: String) {
        self.isBase = baseCode == code ? true : false
        self.baseCode = baseCode
    }
    
    func didSetNew(baseValue: Float) {
        if !isBase {
            self.baseValue = baseValue
        }
    }
    
    func setNew(baseValue: Float) {
        self.baseValueObserver?(baseValue)
    }
    
    private func loadData() {
        let url = AppConfig.currencyDataBaseUrl + "/latest?base=" + code
        task = NetworkTask<Currency>()
        task?.execute(getUrl: url, completion: { (result) in
            switch result {
            case .success(let data):
                self.data = data
                self.uiObserver?()
            case .fail(let error):
                print(error)
            }
        })
    }
    
    deinit {
        print("deinit - CurrencyItemModel")
    }
}
