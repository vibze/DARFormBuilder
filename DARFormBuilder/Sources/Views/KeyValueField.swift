//
//  KeyValueField.swift
//  DARFormBuilder
//
//  Created by Viktor Ten on 1/26/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit


public class KeyValueField: UIView, TextInputAccessoryViewHolder {
    
    let label = UILabel()
    let field = UITextField()
    let iconImage = UIImageView()
    
    public var isEnabled = true {
        didSet {
            field.isEnabled = isEnabled
        }
    }
    
    public var value: String {
        get { return field.text! }
        set (v) { field.text = v.description }
    }
    
    let textInputAccessoryView = TextInputAccessoryView()
    
    public override var canBecomeFirstResponder: Bool {
        return true
    }
    
    public init(_ key: String, value: String = "", isEnabled: Bool = true, icon: UIImage? = nil) {
        super.init(frame: CGRect.zero)
        
        label.text = key
        field.text = "\(value)"
        field.textAlignment = .right
        field.isEnabled = isEnabled
        
        addSubview(label)
        addSubview(field)
        
        field.inputAccessoryView = textInputAccessoryView
        textInputAccessoryView.holder = self
        
        if icon != nil {
            iconImage.image = icon
            addSubview(iconImage)
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func becomeFirstResponder() -> Bool {
        field.becomeFirstResponder()
        return true
    }
    
    override public var inputAccessoryView: UIView? {
        get { return field.inputAccessoryView }
        set (v) { field.inputAccessoryView = v }
    }
    
    func mountTextInputAccessoryView(_ view: TextInputAccessoryView) {
        field.inputAccessoryView = view
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        let width = bounds.width
        guard iconImage.image == nil else {
            iconImage.frame = CGRect(x: 0, y: 0, width: width/12, height: width/12)
            label.frame = CGRect(x: width/10, y: 0, width: width/2, height: bounds.height)
            field.frame = CGRect(x: width/2, y: 0, width: width/2, height: bounds.height)
            return
        }
        label.frame = CGRect(x: 0, y: 0, width: width/2, height: bounds.height)
        field.frame = CGRect(x: width/2, y: 0, width: width/2, height: bounds.height)
    }
}
