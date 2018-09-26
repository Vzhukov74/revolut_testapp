//
//  StringExt.swift
//  revolut_testapp
//
//  Created by Maximal Mac on 26.09.2018.
//  Copyright © 2018 vc. All rights reserved.
//

import Foundation

extension String {
    func isNumberOrDot() -> Bool {
        let range = self.range(of: "^[0-9.]{0,1}$", options: .regularExpression, range: nil, locale: nil)
        return range != nil
    }
}
