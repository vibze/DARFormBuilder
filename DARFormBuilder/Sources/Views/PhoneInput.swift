//
//  PhoneInput.swift
//  DARFormBuilder
//
//  Created by Apple on 2/15/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit


/**
 Masked phone number input based on `TextInput`
 Can also display select from contacts button
 
 
 ## Properties in addition to TextInput
 
 `mask` — Mask template
 */
open class PhoneInput: TextInput {
    
    public var textMask: String {
        get {
            return maskedTextField.formatPattern
        }
        set (v) {
            maskedTextField.formatPattern = v
        }
    }
    
    var maskedTextField: SwiftMaskTextfield {
        return textField as! SwiftMaskTextfield
    }
    
    public override init(_ placeholder: String) {
        super.init(placeholder)
        
        textField = SwiftMaskTextfield()
        textMask = "+# ### ###-##-##"
        textField.keyboardType = .numberPad
        textField.autocorrectionType = .no
        textField.rightViewMode = .always
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: frame.height))
        textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        textField.delegate = self
        textField.inputAccessoryView = textInputAccessoryView
        addSubview(textField)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
