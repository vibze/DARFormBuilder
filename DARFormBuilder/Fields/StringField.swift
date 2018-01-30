//
//  StringField.swift
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
 
 */
public class StringField: UITextField, UITextFieldDelegate, CanMountTextInputAccessoryView {
    
    public var onTextChange: ((String) -> Void)?
    
    public var maxLength: Int = 0 {
        didSet {
            updateCountLabel()
        }
    }
    
    public override var text: String? {
        didSet {
            textDidChange(self)
        }
    }
    
    private let countLabel = UILabel()
    private let placeholderLabel = UILabel()
    private var currentTextLength: Int {
        return text?.count ?? 0
    }
    
    public init(_ placeholder: String = "", maxLength: Int = 0) {
        super.init(frame: CGRect.zero)
        
        placeholderLabel.text = placeholder
        self.maxLength = maxLength
        
        addSubview(countLabel)
        addSubview(placeholderLabel)
        
        countLabel.textColor = config.labelTextColor
        countLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        updateCountLabel()
        
        placeholderLabel.textColor = config.labelTextColor
        placeholderLabel.font = font
        
        rightViewMode = .always
        rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: frame.height))
        
        addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        delegate = self
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        countLabel.sizeToFit()
        countLabel.frame.origin = CGPoint(x: bounds.width - countLabel.frame.width, y: bounds.height - countLabel.frame.height)
        rightView?.frame.size = CGSize(width: countLabel.frame.width + 5, height: frame.height)
        textDidChange(self)
    }
    
    func textDidChange(_ sender: UITextField) {
        updateCountLabel()
        updatePlaceholder()
        onTextChange?(text!)
    }
    
    func mountTextInputAccessoryView(_ view: TextInputAccessoryView) {
        inputAccessoryView = view
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newText = (self.text! as NSString).replacingCharacters(in: range as NSRange, with: string)
        if maxLength > 0 && newText.count > maxLength {
            return false
        }
        
        return true
    }
    
    private func updateCountLabel() {
        countLabel.text = maxLength > 0 ? "\(currentTextLength)/\(maxLength)" : ""
    }
    
    private func updatePlaceholder() {
        currentTextLength > 0 ? floatLabel() : groundLabel()
    }
    
    private func floatLabel() {
        placeholderLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        UIView.animate(withDuration: 0.1) {
            self.placeholderLabel.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            self.placeholderLabel.sizeToFit()
            self.placeholderLabel.frame.origin = CGPoint(x: 0, y: -12)
        }
    }
    
    private func groundLabel() {
        placeholderLabel.font = UIFont.preferredFont(forTextStyle: .body)
        UIView.animate(withDuration: 0.1) {
            self.placeholderLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.placeholderLabel.frame = self.bounds
        }
    }
}
