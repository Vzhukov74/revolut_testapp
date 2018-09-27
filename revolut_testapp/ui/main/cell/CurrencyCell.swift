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
    
    var item: CurrencyItemModel? {
        didSet {
            setup()
            item?.uiObserver = { [weak self] in
                self?.update()
            }
        }
    }
    
    func setFirstResponder() {
        valueInput.becomeFirstResponder()
    }
    
    func endEditing() {
        valueInput.resignFirstResponder()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        item?.uiObserver = nil
        item = nil
        
        codeLabel.text = ""
        iconLabel.text = ""
        transcriptLabel.text = ""
        valueInput.text = ""
        endEditing()
    }
    
    private func setup() {
        if let item = self.item {
            codeLabel.text = item.currencyCode
            iconLabel.text = item.icon
            transcriptLabel.text = item.transcript
            setValueLabel(with: item.value)
        }
    }
    
    private func update() {
        if let item = self.item, !item.isBase {
            setValueLabel(with: item.value)
        }
    }
    
    private func setValueLabel(with value: Float) {
        let str = String(format: "%.2f", value)
        valueInput.text = str
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
        if string.isNumberOrDot() {
            guard var text = textField.text, let range = Range(range, in: text) else { return true }
            
            if text == "0" {
                text = string
            } else {
               text.replaceSubrange(range, with: string)
            }
            
            if text.isEmpty {
                text = "0"
            }
            
            if let value = Float(text) {
                item?.setNew(baseValue: value)
            }
            textField.text = text
            return false
        } else {
            return false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
