//
//  CurrencyListModel.swift
//  revolut_testapp
//
//  Created by Maximal Mac on 21.09.2018.
//  Copyright © 2018 vc. All rights reserved.
//

import Foundation

class CurrencyItemModel {
    private let code: String
    private var task: NetworkTask<Currency>?
    private(set) var data: Currency?
    
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
    
    deinit {
        print("deinit - CurrencyItemModel")
    }
}

class CurrencyListModel {
    private(set) var items: [CurrencyItemModel] = []
    
    init() {
        ApiData.currencyCodes.forEach { items.append(CurrencyItemModel(code: $0)) }
    }
}
