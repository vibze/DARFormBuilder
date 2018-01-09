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
public class TextInputCell: BaseCell, UITextViewDelegate {
    
    var onTextChange: ((String) -> Void)?
    
    var keyboardType = UIKeyboardType.default
    var placeholder: String = ""
    var textValue = ""
    var maxLength: Int = 0
    
    let textView = UITextView()
    let countLabel = UILabel()
    let placeholderLabel = UILabel()
    var textViewHeightConstraint: NSLayoutConstraint? = nil
        
    public convenience init(placeholder: String, value: String = "", keyboardType: UIKeyboardType = .default, maxLength: Int = 0, onChange: ((String) -> Void)?) {
        self.init(style: .default, reuseIdentifier: nil)
        self.textValue = value
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self.maxLength = maxLength
        onTextChange = onChange
    }
    
    override func configureSubviews() {
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.delegate = self
        textView.backgroundColor = UIColor.clear
        textView.textContainerInset = UIEdgeInsets.zero
        textView.textContainer.lineFragmentPadding = 0
        textView.bounces = false
        
        countLabel.font = UIFont.systemFont(ofSize: 12)
        countLabel.textColor = UIColor.lightGray
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
            NSLayoutConstraint(item: textView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: padding.top),
            NSLayoutConstraint(item: textView, attribute: .trailing, relatedBy: .equal, toItem: countLabel, attribute: .leading, multiplier: 1, constant: -5),
            NSLayoutConstraint(item: textView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -padding.bottom),
            textViewHeightConstraint!
            ])
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: placeholderLabel, attribute: .leading, relatedBy: .equal, toItem: textView, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: placeholderLabel, attribute: .top, relatedBy: .equal, toItem: textView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: placeholderLabel, attribute: .bottom, relatedBy: .equal, toItem: textView, attribute: .bottom, multiplier: 1, constant: 0)
            ])
        
        updateTextViewHeight(for: textView.text)
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        let currentLength = textView.text.count
        
        if maxLength != 0 {
            guard currentLength <= maxLength else { return }
        }
        
        placeholderLabel.isHidden = currentLength > 0
        
        countLabel.text = "\(currentLength)/\(maxLength)"
        onTextChange?(textView.text)
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
        placeholderLabel.isHidden = currentLength > 0
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentLength = textView.text.count
        
        let newText = (textView.text as! NSString).replacingCharacters(in: range, with: text)
        updateTextViewHeight(for: newText)
        
        if (range.length + range.location > currentLength) {
            return false
        }
        let newLength = currentLength + text.count - range.length
        return newLength <= maxLength
    }
    
    private func updateTextViewHeight(for text: String) {
        let size = text.boundingRect(
            with: CGSize(width: textView.textContainer.size.width - textView.textContainer.lineFragmentPadding - 5, height: .infinity),
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedStringKey.font: textView.font!],
            context: nil
        )
        let height = size.height + textView.textContainerInset.top + textView.textContainerInset.bottom + 1
        textViewHeightConstraint?.constant = height
        delegate?.formBuilderCellDidUpdateHeight()
    }
}
