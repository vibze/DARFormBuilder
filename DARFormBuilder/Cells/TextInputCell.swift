//
//  TextInputCell.swift
//  DARFormBuilder
//
//  Created by Apple on 1/5/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit


/**
 Текстовое поле
 */
public class TextInputCell: BaseCell, UITextFieldDelegate {
    
    var onTextChange: ((String) -> Void)?
    
    var keyboardType = UIKeyboardType.default
    var placeholder: String = ""
    var textValue = ""
    var maxLength: Int = 0
    
    let textField = UITextField()
    let countLabel = UILabel()
    
    public convenience init(value: String = "", placeholder: String, keyboardType: UIKeyboardType = .default, maxLength: Int = 0, onChange: ((String) -> Void)?) {
        self.init(style: .default, reuseIdentifier: nil)
        self.textValue = value
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self.maxLength = maxLength
        onTextChange = onChange
    }
    
    override func configureSubviews() {
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.addTarget(self, action: #selector(textChange), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        
        countLabel.font = UIFont.systemFont(ofSize: 12)
        countLabel.textColor = UIColor.lightGray
        countLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func addSubviews() {
        contentView.addSubview(textField)
        contentView.addSubview(countLabel)
    }
    
    override func configureConstraints() {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: countLabel, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -padding.right),
            NSLayoutConstraint(item: countLabel, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -padding.bottom)
            ])
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: textField, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: padding.left),
            NSLayoutConstraint(item: textField, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: padding.top),
            NSLayoutConstraint(item: textField, attribute: .trailing, relatedBy: .equal, toItem: countLabel, attribute: .leading, multiplier: 1, constant: -5),
            NSLayoutConstraint(item: textField, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -padding.bottom)
            ])
    }

    @objc private func textChange(_ sender: UITextField) {
        let currentLength = sender.text?.count ?? 0
        
        if maxLength != 0 {
            guard currentLength <= maxLength else { return }
        }
        
        countLabel.text = "\(currentLength)/\(maxLength)"
        onTextChange?(sender.text!)
    }
    
    override func configureCell() {
        let currentLength = textValue.count

        textField.text = textValue
        textField.placeholder = placeholder
        textField.keyboardType = keyboardType
        countLabel.text = "\(currentLength)/\(maxLength)"
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentLength = textField.text?.count ?? 0
        if (range.length + range.location > currentLength) {
            return false
        }
        let newLength = currentLength + string.count - range.length
        return newLength <= maxLength
    }
}
