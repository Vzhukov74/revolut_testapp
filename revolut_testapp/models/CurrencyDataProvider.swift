//
//  CurrencyDataProvider.swift
//  revolut_testapp
//
//  Created by Maximal Mac on 25.09.2018.
//  Copyright © 2018 vc. All rights reserved.
//

import Foundation

class CurrencyDataProvider {
    let currencyCode: String
    private var task: NetworkTask<Currency>?
    private var _data: Currency? {
        didSet {
            self.subscriber?()
        }
    }
    
    var data: Currency? {
        return _data
    }
    
    var subscriber: (() -> Void)?
    
    init(currencyCode code: String) {
        self.currencyCode = code
    }
    
    func loadData() {
        let url = AppConfig.currencyDataBaseUrl + "/latest?base=" + currencyCode
        task = NetworkTask<Currency>()
        task?.execute(getUrl: url, completion: { (result) in
            switch result {
            case .success(let data):
                self._data = data
            case .fail(let error):
                print(error)
            }
        })
    }
}
