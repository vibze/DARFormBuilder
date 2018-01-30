//
//  KeyValueField.swift
//  DARFormBuilder
//
//  Created by Apple on 1/26/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit


public class KeyValueField: UIView, CanMountTextInputAccessoryView {
    
    let label = UILabel()
    let field = UITextField()
    
    var isEnabled = true {
        didSet {
            field.isEnabled = isEnabled
        }
    }
    
    public override var canBecomeFirstResponder: Bool {
        return true
    }
    
    public init(_ key: String, value: String = "") {
        super.init(frame: CGRect.zero)
        
        label.text = key
        field.text = "\(value)"
        field.textAlignment = .right
        
        addSubview(label)
        addSubview(field)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func becomeFirstResponder() -> Bool {
        field.becomeFirstResponder()
        return true
    }
    
    func mountTextInputAccessoryView(_ view: TextInputAccessoryView) {
        field.inputAccessoryView = view
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        label.frame = CGRect(x: 0, y: 0, width: bounds.width/2, height: bounds.height)
        field.frame = CGRect(x: bounds.width/2, y: 0, width: bounds.width/2, height: bounds.height)
    }
}
