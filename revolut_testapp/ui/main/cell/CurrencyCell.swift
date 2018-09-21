//
//  CurrencyCell.swift
//  revolut_testapp
//
//  Created by Maximal Mac on 19.09.2018.
//  Copyright © 2018 vc. All rights reserved.
//

import UIKit

class CurrencyCell: UITableViewCell, CellRegistable, CellDequeueReusable {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var transcriptLabel: UILabel!
    @IBOutlet weak var valueInput: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var item: CurrencyItemModel? {
        didSet {
            setup()
            item?.observer = {
                self.setup()
            }
        }
    }
    
    private func setup() {
        codeLabel.text = item?.data?.base
    }
    
    func becomeFirstResponde() {
        valueInput.text = "becomeFirstResponder"
    }
}

protocol CellRegistable { }

extension CellRegistable {
    static func register(table: UITableView) {
        table.register(UINib.init(nibName: String(describing: self), bundle: nil), forCellReuseIdentifier: String(describing: self))
    }
}

protocol CellDequeueReusable { }

extension CellDequeueReusable {
    static func cell(table: UITableView, indexPath: IndexPath) -> Self {
        let cell = table.dequeueReusableCell(withIdentifier: String(describing: self), for: indexPath) as! Self
        return cell
    }
}
