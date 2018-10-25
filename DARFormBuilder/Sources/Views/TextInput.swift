//
//  TextInput.swift
//  DARFormBuilder
//
//  Created by Viktor Ten on 1/26/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit


/**
 Standard string input field with floating placeholder label.
 
 Supports max length limit. Max length is displayed in a label in bottom right corner
 of the field.

 
 ## Properties
 
 `onTextChange` - Callback for text change

 `maxLength` - Maximum length of text
 
 `text` - Text value of the field
 
 `isFloating` - For floating placeholder
 
 */
open class TextInput: UIView, UITextFieldDelegate, TextInputAccessoryViewHolder,
                      CanCalculateOwnHeight, CanBeValidated {
    
    open var text: String? {
        didSet {
            textField.text = text
            textDidChange(textField)
        }
    }
    
    open var height: CGFloat {
        return 30
    }
    
    open var currentTextLength: Int {
        return textField.text?.count ?? 0
    }
    
    open var keyboardType: UIKeyboardType {
        get { return textField.keyboardType }
        set (v) { textField.keyboardType = v }
    }
    
    open var isEnabled: Bool {
        get { return textField.isEnabled }
        set (v) { textField.isEnabled = v }
    }
    
    open var textAttributes = [NSAttributedStringKey: Any]() {
        didSet {
            guard let text = textField.text else { return }
            textField.attributedText = NSAttributedString(string: text, attributes: textAttributes)
        }
    }
    
    public var onTextChange: ((String) -> Void)?
    public var textField = UITextField()
    public let countLabel = UILabel()
    public let placeholderLabel = UILabel()
    public let textInputAccessoryView = TextInputAccessoryView()
    
    public var isRequired = false
    public var isFloating = true
    public var maxLength = 0 {
        didSet { updateCountLabel() }
    }
    
    public init(_ placeholder: String = "", isFloat: Bool = true) {
        super.init(frame: CGRect.zero)

        addSubview(textField)
        addSubview(countLabel)
        addSubview(placeholderLabel)
        
        countLabel.textAlignment = .right
        countLabel.textColor = config.labelTextColor
        countLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        
        placeholderLabel.text = placeholder
        placeholderLabel.isHidden = false
        placeholderLabel.textColor = config.labelTextColor
        placeholderLabel.font = textField.font
        
        textField.autocorrectionType = .no
        textField.rightViewMode = .always
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: frame.height))
        textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        textField.delegate = self
        textField.inputAccessoryView = textInputAccessoryView
    
        textInputAccessoryView.holder = self
        
        updateCountLabel()
        
        guard isFloat else {
            placeholderLabel.isHidden = true
            textField.placeholder = placeholder
            return
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override var canBecomeFirstResponder: Bool {
        return true
    }
    
    open override func becomeFirstResponder() -> Bool {
        textField.becomeFirstResponder()
        return true
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        textField.frame = CGRect(x: 0, y: 10, width: bounds.width, height: height - 7)
        textDidChange(textField)
    }

    @objc open func textDidChange(_ sender: UITextField) {
        hideError()
        updateCountLabel()
        updatePlaceholder()
        onTextChange?(sender.text!)
    }
    
    open func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newText = (textField.text! as NSString).replacingCharacters(in: range as NSRange, with: string)
        if maxLength > 0 && newText.count > maxLength {
            return false
        }
        
        return true
    }
    
    
    // MARK: CanBeValidated
    
    open var errors: [String] {
        var errors: [String] = []
        
        if isRequired && textField.text == "" {
            errors.append("Не заполнено поле: \(placeholderLabel.text)")
        }
        
        if maxLength > 0 && currentTextLength > maxLength {
            errors.append("Поле '\(placeholderLabel.text)' превышает допустимую длину")
        }
        
        return errors
    }
    
    open func showError() {
        placeholderLabel.textColor = UIColor.red
        textField.textColor = UIColor.red
    }
    
    open func hideError() {
        placeholderLabel.textColor = config.labelTextColor
        textField.textColor = config.primaryTextColor
    }
    
    
    // MARK: Private methods
    
    private func updateCountLabel() {
        countLabel.text = maxLength > 0 ? "\(currentTextLength)/\(maxLength)" : ""
        countLabel.sizeToFit()
        countLabel.frame.origin = CGPoint(x: bounds.width - countLabel.frame.width, y: textField.frame.maxY - countLabel.frame.height + 1)
        textField.rightView?.frame.size = CGSize(width: countLabel.frame.width + 5, height: textField.frame.height)
    }
    
    private func updatePlaceholder() {
        currentTextLength > 0 ? floatLabel() : groundLabel()
    }
    
    private func floatLabel() {
        UIView.animate(withDuration: 0.1) {
            self.placeholderLabel.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            self.placeholderLabel.sizeToFit()
            self.placeholderLabel.frame.origin = CGPoint(x: 0, y: -5)
        }
    }
    
    private func groundLabel() {
        UIView.animate(withDuration: 0.1) {
            self.placeholderLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.placeholderLabel.frame = CGRect(x: 0, y: 10, width: self.bounds.width, height: self.bounds.height - 7)
        }
    }
}
