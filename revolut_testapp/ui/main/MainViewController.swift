//
//  MainViewController.swift
//  revolut_testapp
//
//  Created by Maximal Mac on 19.09.2018.
//  Copyright © 2018 vc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            CurrencyCell.register(table: tableView)
            
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    var task: URLSessionDataTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: ApiData.currencyDataBaseUrl + "/latest?base=EUR")
        
        task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, responce, error) in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(Currency.self, from: data)
                    print(result)
                } catch {
                    print(error)
                }
            }
        })
        task?.resume()
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return CurrencyCell.cell(table: tableView, indexPath: indexPath)
    }
}

extension MainViewController: StoryboardInstanceable {
    static var storyboardName: StoryboardList = .main
}
