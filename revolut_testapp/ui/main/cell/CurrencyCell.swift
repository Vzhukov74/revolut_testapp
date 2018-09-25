//
//  CurrencyCell.swift
//  revolut_testapp
//
//  Created by Maximal Mac on 19.09.2018.
//  Copyright © 2018 vc. All rights reserved.
//

import UIKit

class CurrencyCell: UITableViewCell, CellRegistable, CellDequeueReusable {
    
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var transcriptLabel: UILabel!
    @IBOutlet weak var valueInput: UITextField! {
        didSet {
            valueInput.delegate = self
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        item?.uiObserver = nil
        item = nil
    }
    
    var item: CurrencyItemModel? {
        didSet {
            setup()
            item?.uiObserver = {
                self.update()
            }
        }
    }
    
    private func setup() {
        if let item = self.item {
            codeLabel.text = item.currencyCode
            iconLabel.text = AppConfig.currencyCodeToDetailInfoMapping[item.currencyCode]?.flag
            transcriptLabel.text = AppConfig.currencyCodeToDetailInfoMapping[item.currencyCode]?.name
            valueInput.text = String(item.value)
        }
    }
    
    private func update() {
        if let item = self.item, !item.isBase {
            valueInput.text = String(item.value)
            valueInput.resignFirstResponder()
        }
    }
}

extension CurrencyCell: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return item?.isBase ?? false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let valueAsStr = textField.text, let value = Float(valueAsStr) else { return }
        item?.setNew(baseValue: value)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isNumber() {
            guard var text = textField.text, let range = Range(range, in: text) else { return true }
            text.replaceSubrange(range, with: string)
            if let value = Float(text) {
                item?.setNew(baseValue: value)
            }
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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

extension String {
    func isNumber() -> Bool {
        let range = self.range(of: "^[0-9.]{0,1}$", options: .regularExpression, range: nil, locale: nil)
        return range != nil
    }
}
