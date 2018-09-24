//
//  AppDelegate.swift
//  revolut_testapp
//
//  Created by Maximal Mac on 19.09.2018.
//  Copyright © 2018 vc. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = CurrencyListViewController.storyboardInstance
        vc?.model = CurrencyListModel(with: AppConfig.currencyCodes)
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        return true
    }
}
