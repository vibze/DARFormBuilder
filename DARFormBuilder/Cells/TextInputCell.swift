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
class TextInputCell: BaseCell {
    
    var onTextChange: ((String) -> Void)?
    
    var keyboardType = UIKeyboardType.default {
        didSet {
            textField.keyboardType = keyboardType
        }
    }
    
    var placeholder: String = "" {
        didSet {
            textField.placeholder = placeholder
        }
    }
    
    var textValue = "" {
        didSet {
            textField.text = textValue
        }
    }
    
    let textField = UITextField()
    
    override func configureSubviews() {
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.addTarget(self, action: #selector(textChange), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func addSubviews() {
        contentView.addSubview(textField)
    }
    
    override func configureConstraints() {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: textField, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: padding.left),
            NSLayoutConstraint(item: textField, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: padding.top),
            NSLayoutConstraint(item: textField, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -padding.right),
            NSLayoutConstraint(item: textField, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -padding.bottom)
            ])
    }

    @objc private func textChange(_ sender: UITextField) {
        onTextChange?(sender.text!)
    }
    
}
