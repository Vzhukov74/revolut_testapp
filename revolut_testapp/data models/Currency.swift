//
//  Currency.swift
//  revolut_testapp
//
//  Created by Maximal Mac on 20.09.2018.
//  Copyright © 2018 vc. All rights reserved.
//

import Foundation

struct Currency: Codable {
    var base: String
    var date: String
    var rates: [String: Float]
}
