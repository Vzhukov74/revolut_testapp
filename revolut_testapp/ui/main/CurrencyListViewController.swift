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
        
        let firstElementIndexPath = IndexPath(row: 0, section: 0)
        let secondElementIndexPath = IndexPath(row: 0, section: 0)
        
        model.swapItem(at: indexPath.row, to: firstElementIndexPath.row)
        tableView.performBatchUpdates({
            tableView.moveRow(at: indexPath, to: firstElementIndexPath)
        }, completion: { [weak self] (_) in
            UIView.animate(withDuration: 0.3, animations: {
                self?.tableView.scrollToRow(at: firstElementIndexPath, at: UITableView.ScrollPosition.top, animated: true)
            }, completion: { (_) in
                let firstCell = tableView.cellForRow(at: firstElementIndexPath) as? CurrencyCell
                let secondCell = tableView.cellForRow(at: secondElementIndexPath) as? CurrencyCell
                
                secondCell?.endEditing()
                firstCell?.setFirstResponder()
            })
        })
    }
}

extension CurrencyListViewController: StoryboardInstanceable {
    static var storyboardName: StoryboardList = .main
}
