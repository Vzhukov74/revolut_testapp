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
    private(set) var data: Currency? {
        didSet {
            self.subscriber?()
        }
    }
    var subscriber: (() -> Void)?
    
    init(currencyCode code: String) {
        currencyCode = code
    }
    
    func loadData() {
        let url = AppConfig.currencyDataBaseUrl + "/latest?base=" + currencyCode
        task = NetworkTask<Currency>()
        task?.execute(getUrl: url, completion: { (result) in
            switch result {
            case .success(let data):
                self.data = data
            case .fail(let error):
                print(error)
            }
        })
    }
}
