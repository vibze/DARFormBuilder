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
public class TextInputCell: BaseCell, UITextViewDelegate, TextInputAccessoryViewDelegate {
    
    var onTextChange: ((String) -> Void)?
    
    var keyboardType = UIKeyboardType.default
    var placeholder: String = ""
    var textValue = ""
    var maxLength: Int = 0
    let textInputAccessoryView = TextInputAccessoryView()
    let textView = UITextView()
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
        textView.becomeFirstResponder()
    }
    
    override func blur() {
        textView.resignFirstResponder()
    }
    
    override func configureSubviews() {
        textView.font = UIFont.systemFont(ofSize: config.fontSize)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.delegate = self
        textView.backgroundColor = UIColor.clear
        textView.textColor = config.primaryTextColor
        textView.textContainerInset = UIEdgeInsets.zero
        textView.textContainer.lineFragmentPadding = 0
        textView.bounces = false
        textView.inputAccessoryView = textInputAccessoryView
        textView.inputAccessoryView?.frame = CGRect(x: 0, y: 0, width: 1, height: 44)
        textInputAccessoryView.delegate = self
        
        countLabel.font = UIFont.systemFont(ofSize: 12)
        countLabel.textColor = config.labelTextColor
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        
        placeholderLabel.font = textView.font
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func addSubviews() {
        contentView.addSubview(placeholderLabel)
        contentView.addSubview(textView)
        contentView.addSubview(countLabel)
    }
    
    override func configureConstraints() {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: countLabel, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -padding.right),
            NSLayoutConstraint(item: countLabel, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -padding.bottom)
            ])
        
        textViewHeightConstraint = NSLayoutConstraint(item: textView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 60)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: textView, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: padding.left),
            NSLayoutConstraint(item: textView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: padding.top + 10),
            NSLayoutConstraint(item: textView, attribute: .trailing, relatedBy: .equal, toItem: countLabel, attribute: .leading, multiplier: 1, constant: -5),
            NSLayoutConstraint(item: textView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -padding.bottom),
            textViewHeightConstraint!
            ])
        
        placeholderLabelTopConstraint = NSLayoutConstraint(item: placeholderLabel, attribute: .top, relatedBy: .equal, toItem: textView, attribute: .top, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: placeholderLabel, attribute: .leading, relatedBy: .equal, toItem: textView, attribute: .leading, multiplier: 1, constant: 0),
            placeholderLabelTopConstraint!
            ])

        updateTextViewHeight(for: textView.text)
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        let currentLength = textView.text.count
        
        if maxLength != 0 {
            guard currentLength <= maxLength else { return }
            countLabel.text = "\(currentLength)/\(maxLength)"
        }
        
        onTextChange?(textView.text)
        textValue = textView.text
        
        currentLength > 0 ? floatLabel() : groundLabel()
    }
    
    override func configureCell() {
        let currentLength = textValue.count

        textView.text = textValue
        textView.keyboardType = keyboardType
        countLabel.text = "\(currentLength)/\(maxLength)"
        if maxLength == 0 {
            countLabel.text = ""
        }
        placeholderLabel.text = placeholder
        currentLength > 0 ? floatLabel() : groundLabel()
    }

    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text! as NSString).replacingCharacters(in: range, with: text)
        updateTextViewHeight(for: newText)
        
        if maxLength == 0 {
            return true
        }
        
        let newLength = newText.count
        return newLength <= maxLength
    }
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        textInputAccessoryView.prevButton.isEnabled = delegate?.formBuilderCellPrevFocusableCell(self) != nil
        textInputAccessoryView.nextButton.isEnabled = delegate?.formBuilderCellNextFocusableCell(self) != nil
        delegate?.formBuilderCellScrollToCell(self)
    }
    
    private func updateTextViewHeight(for text: String) {
        let size = text.boundingRect(
            with: CGSize(width: textView.textContainer.size.width - textView.textContainer.lineFragmentPadding - 5, height: .infinity),
            options: .usesLineFragmentOrigin,
            attributes: [NSFontAttributeName: textView.font!],
            context: nil
        )
        let height = size.height + textView.textContainerInset.top + textView.textContainerInset.bottom + 1
        textViewHeightConstraint?.constant = height
        delegate?.formBuilderCellDidUpdateHeight()
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
        placeholderLabel.font = textView.font
        UIView.animate(withDuration: 0.1) {
            self.layoutIfNeeded()
        }
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
        textView.resignFirstResponder()
    }
    
    override public func showError() {
        placeholderLabel.textColor = .red
        countLabel.textColor = .red
    }
    
    override public func hideError() {
        placeholderLabel.textColor = .lightGray
        countLabel.textColor = .lightGray
    }
}
