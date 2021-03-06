//
//  SelectFieldWithAction.swift
//  DARFormBuilder
//
//  Created by Kamila Kusainova on 24.10.2018.
//

import UIKit

/**
 Select field th action .
 .
 
 ## Properties:
 
  `textAttributes` - attributes of text(color, font and etc.)
 
 **/

public class SelectFieldWithAction: UIView {
    
    var field = UITextField()
    var button = UIButton()
    public var action: ((UITapGestureRecognizer) -> Void)? = nil
    
    public var textAttributes = [NSAttributedStringKey: Any]() {
        didSet {
            guard let text = field.text else { return }
            field.attributedText = NSAttributedString(string: text , attributes: textAttributes)
        }
    }
    
    public init(_ title: String,icon: UIImage? = nil) {
        super.init(frame: .zero)
        field.text = title
        field.isEnabled = false

        if icon != nil {
            button.setImage(icon, for: .normal)
        }
        
        field.rightView = button
        field.rightViewMode = .always
        let tgs = UITapGestureRecognizer(target: self, action: #selector(didTapField))
        
        addSubview(field)
        addGestureRecognizer(tgs)
        
    }
    
    @objc func didTapField(_ sender: UITapGestureRecognizer) {
        action?(sender)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        field.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        button.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
