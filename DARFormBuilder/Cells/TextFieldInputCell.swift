//
//  TextFieldInputCell.swift
//  DARFormBuilder
//
//  Created by Darkhan Mukatay on 10/01/2018.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit

public class TextFieldInputCell: BaseCell, UITextFieldDelegate, TextInputAccessoryViewDelegate {
    
    var onTextChange: ((String) -> Void)?
    
    var keyboardType = UIKeyboardType.default
    var placeholder: String = ""
    var textValue = ""
    var maxLength: Int = 0
    
    let textInputAccessoryView = TextInputAccessoryView()
    let textField = UITextField()
    let countLabel = UILabel()
    let placeholderLabel = UILabel()
    var textViewHeightConstraint: NSLayoutConstraint? = nil
    var placeholderLabelTopConstraint: NSLayoutConstraint? = nil
    
    public convenience init(placeholder: String, value: String = "", keyboardType: UIKeyboardType = .default, maxLength: Int = 0, onChange: ((String) -> Void)?) {
        self.init(style: .default, reuseIdentifier: nil)
        self.textValue = value
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self.maxLength = maxLength
        onTextChange = onChange
    }
    
    public override var canBecomeFocused: Bool {
        return true
    }
    
    override func focus() {
        textField.becomeFirstResponder()
    }
    
    override func blur() {
        textField.resignFirstResponder()
    }
    
    override func configureSubviews() {
        textField.font = UIFont.systemFont(ofSize: config.fontSize)
        textField.addTarget(self, action: #selector(textChange), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.returnKeyType = .next
        textField.inputAccessoryView = textInputAccessoryView
        textField.inputAccessoryView?.frame = CGRect(x: 0, y: 0, width: 1, height: 44)
        textInputAccessoryView.delegate = self
        
        countLabel.font = UIFont.systemFont(ofSize: 12)
        countLabel.textColor = UIColor.lightGray
        countLabel.textAlignment = .right
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        
        placeholderLabel.font = textField.font
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func addSubviews() {
        contentView.addSubview(placeholderLabel)
        contentView.addSubview(textField)
        contentView.addSubview(countLabel)
    }
    
    override func configureConstraints() {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: textField, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: padding.left),
            NSLayoutConstraint(item: textField, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: padding.top + 10),
            NSLayoutConstraint(item: textField, attribute: .trailing, relatedBy: .equal, toItem: countLabel, attribute: .leading, multiplier: 1, constant: -5),
            NSLayoutConstraint(item: textField, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -padding.bottom)
            ])
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: countLabel, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -padding.right),
            NSLayoutConstraint(item: countLabel, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -padding.bottom)
            ])
        countLabel.setContentCompressionResistancePriority(UILayoutPriorityRequired, for: .horizontal)
        
        placeholderLabelTopConstraint = NSLayoutConstraint(item: placeholderLabel, attribute: .top, relatedBy: .equal, toItem: textField, attribute: .top, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: placeholderLabel, attribute: .leading, relatedBy: .equal, toItem: textField, attribute: .leading, multiplier: 1, constant: 0),
            placeholderLabelTopConstraint!
            ])
    }
    
    func textChange(_ sender: UITextField) {
        let currentLength = sender.text?.count ?? 0
        
        if maxLength != 0 {
            guard currentLength <= maxLength else { return }
            countLabel.text = "\(currentLength)/\(maxLength)"
        }
        
        textValue = textField.text!
        currentLength > 0 ? floatLabel() : groundLabel()
        onTextChange?(sender.text!)
    }
    
    func floatLabel() {
        placeholderLabelTopConstraint?.constant = -14
        placeholderLabel.font = UIFont.systemFont(ofSize: 11)
        UIView.animate(withDuration: 0.1) {
            self.layoutIfNeeded()
        }
    }
    
    func groundLabel() {
        placeholderLabelTopConstraint?.constant = 0
        placeholderLabel.font = textField.font
        UIView.animate(withDuration: 0.1) {
            self.layoutIfNeeded()
        }
    }
    
    override func configureCell() {
        let currentLength = textValue.count
        
        textField.text = textValue
        textField.keyboardType = keyboardType
        countLabel.text = "\(currentLength)/\(maxLength)"
        if maxLength == 0 {
            countLabel.text = ""
        }
        placeholderLabel.text = placeholder
        currentLength > 0 ? floatLabel() : groundLabel()
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        textInputAccessoryView.prevButton.isEnabled = delegate?.formBuilderCellPrevFocusableCell(self) != nil
        textInputAccessoryView.nextButton.isEnabled = delegate?.formBuilderCellNextFocusableCell(self) != nil
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentLength = textField.text?.count ?? 0
        
        if maxLength == 0 {
            return true
        }
        
        let newLength = currentLength + string.count - range.length
        return newLength <= maxLength
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let cell = delegate?.formBuilderCellNextFocusableCell(self) {
            delegate?.formBuilderCellScrollToCell(cell)
            cell.focus()
        }
        return false
    }
    
    func textInputAccessoryViewPrev() {
        if let cell = delegate?.formBuilderCellPrevFocusableCell(self) {
            delegate?.formBuilderCellScrollToCell(cell)
            cell.focus()
        }
    }
    
    func textInputAccessoryViewNext() {
        if let cell = delegate?.formBuilderCellNextFocusableCell(self) {
            delegate?.formBuilderCellScrollToCell(cell)
            cell.focus()
        }
    }
    
    func textInputAccessoryViewDone() {
        textField.resignFirstResponder()
    }
}
