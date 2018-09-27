//
//  ApiData.swift
//  revolut_testapp
//
//  Created by Maximal Mac on 20.09.2018.
//  Copyright © 2018 vc. All rights reserved.
//

import Foundation

class AppConfig {
    static let currencyDataBaseUrl = "https://revolut.duckdns.org"
    
    static let currencyCodes = ["EUR", "USD", "AUD", "BGN", "BRL",
                                "CAD", "CHF", "CNY", "CZK", "DKK",
                                "GBP", "HKD", "HRK", "HUF", "IDR",
                                "ILS", "INR", "ISK", "JPY", "KRW",
                                "MXN", "MYR", "NOK", "NZD", "PHP",
                                "PLN", "RON", "RUB", "SEK", "SGD",
                                "THB", "TRY", "ZAR"]
    
    static let currencyUpdateTimeInterval: Double = 1 //in seconds
    
    static let currencyInitBaseValue: Float = 100
    
    static let currencyCodeToDetailInfoMapping = ["EUR": CurrencyDetailInfo(flag: "🇪🇺", name: "Euro"),
                                                  "USD": CurrencyDetailInfo(flag: "🇺🇸", name: "United States dollar"),
                                                  "AUD": CurrencyDetailInfo(flag: "🇦🇺", name: "Australian dollar"),
                                                  "BGN": CurrencyDetailInfo(flag: "🇧🇬", name: "Bulgarian lev"),
                                                  "BRL": CurrencyDetailInfo(flag: "🇧🇷", name: "Brazilian real"),
                                                  "CAD": CurrencyDetailInfo(flag: "🇨🇦", name: "Canadian dollar"),
                                                  "CHF": CurrencyDetailInfo(flag: "🇨🇭", name: "Swiss franc"),
                                                  "CNY": CurrencyDetailInfo(flag: "🇨🇳", name: "Renminbi (Chinese) yuan"),
                                                  "CZK": CurrencyDetailInfo(flag: "🇨🇿", name: "Czech koruna"),
                                                  "DKK": CurrencyDetailInfo(flag: "🇩🇰", name: "Danish krone"),
                                                  "GBP": CurrencyDetailInfo(flag: "🇬🇧", name: "Pound sterling"),
                                                  "HKD": CurrencyDetailInfo(flag: "🇭🇰", name: "Hong Kong dollar"),
                                                  "HRK": CurrencyDetailInfo(flag: "🇭🇷", name: "Croatian kuna"),
                                                  "HUF": CurrencyDetailInfo(flag: "🇭🇺", name: "Hungarian forint"),
                                                  "IDR": CurrencyDetailInfo(flag: "🇲🇨", name: "Indonesian rupiah"),
                                                  "ILS": CurrencyDetailInfo(flag: "🇮🇱", name: "Israeli new shekel"),
                                                  "INR": CurrencyDetailInfo(flag: "🇮🇳", name: "Indian rupee"),
                                                  "ISK": CurrencyDetailInfo(flag: "🇮🇸", name: "Icelandic króna"),
                                                  "JPY": CurrencyDetailInfo(flag: "🇯🇵", name: "Japanese yen"),
                                                  "KRW": CurrencyDetailInfo(flag: "🇰🇷", name: "South Korean won"),
                                                  "MXN": CurrencyDetailInfo(flag: "🇲🇽", name: "Mexican peso"),
                                                  "MYR": CurrencyDetailInfo(flag: "🇲🇾", name: "Malaysian ringgit"),
                                                  "NOK": CurrencyDetailInfo(flag: "🇳🇴", name: "Norwegian krone"),
                                                  "NZD": CurrencyDetailInfo(flag: "🇳🇿", name: "New Zealand dollar"),
                                                  "PHP": CurrencyDetailInfo(flag: "🇵🇭", name: "Philippine peso"),
                                                  "PLN": CurrencyDetailInfo(flag: "🇵🇱", name: "Polish złoty"),
                                                  "RON": CurrencyDetailInfo(flag: "🇷🇴", name: "Romanian leu"),
                                                  "RUB": CurrencyDetailInfo(flag: "🇷🇺", name: "Russian ruble"),
                                                  "SEK": CurrencyDetailInfo(flag: "🇸🇪", name: "Swedish krona/kronor"),
                                                  "SGD": CurrencyDetailInfo(flag: "🇸🇬", name: "Singapore dollar"),
                                                  "THB": CurrencyDetailInfo(flag: "🇹🇭", name: "Thai baht"),
                                                  "TRY": CurrencyDetailInfo(flag: "🇹🇷", name: "Turkish lira"),
                                                  "ZAR": CurrencyDetailInfo(flag: "🇿🇦", name: "South African rand")]
}
