//
//  NetworkTaskResult.swift
//  revolut_testapp
//
//  Created by Maximal Mac on 20.09.2018.
//  Copyright © 2018 vc. All rights reserved.
//

import Foundation

enum NetworkTaskResult<T> {
    case success(T)
    case fail(String)
}
