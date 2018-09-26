//
//  MainViewController.swift
//  revolut_testapp
//
//  Created by Maximal Mac on 19.09.2018.
//  Copyright © 2018 vc. All rights reserved.
//

import UIKit

class CurrencyListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            CurrencyCell.register(table: tableView)
            
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    var model: CurrencyListModel!
}

extension CurrencyListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CurrencyCell.cell(table: tableView, indexPath: indexPath)
        let index = indexPath.row
        cell.item = model.items[index]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard indexPath.row > 0 else { return }
        
        let startIndexPath = IndexPath(row: 0, section: 0)
        
        tableView.performBatchUpdates({
            tableView.moveRow(at: indexPath, to: startIndexPath)
        }, completion: { [weak self] (_) in
            self?.model.swapItem(at: indexPath.row, to: startIndexPath.row)
            self?.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableView.ScrollPosition.top, animated: true)
        })
    }
}

extension CurrencyListViewController: StoryboardInstanceable {
    static var storyboardName: StoryboardList = .main
}
