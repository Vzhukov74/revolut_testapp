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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
