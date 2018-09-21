//
//  StoryboardList.swift
//  revolut_testapp
//
//  Created by Maximal Mac on 19.09.2018.
//  Copyright © 2018 vc. All rights reserved.
//

import UIKit

enum StoryboardList: String {
    case main = "CurrencyListViewController"
}

/*
if vc support this protocol, we supposes that .storyboard file with UI will be have same name as vc
and storyboard id field will be filled
*/
protocol StoryboardInstanceable {
    static var storyboardName: StoryboardList {get set}
}

extension StoryboardInstanceable {
    static var storyboardInstance: Self? {
        let storyboard = UIStoryboard(name: storyboardName.rawValue, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier:String(describing: self)) as? Self
        return vc
    }
}
