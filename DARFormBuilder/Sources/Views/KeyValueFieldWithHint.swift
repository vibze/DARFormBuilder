//
//  KeyValueFieldWithHint.swift
//  DARFormBuilder
//
//  Created by Kamila Kusainova on 29.10.2018.
//

import UIKit

public class KeyValueFieldWithHint: KeyValueField {
    
    let hintLabel = UILabel()
    
    override var height: CGFloat {
        return 30
    }
    
    open var hintTextAttributes = [NSAttributedStringKey: Any]() {
        didSet {
            guard let text = hintLabel.text else { return }
            hintLabel.attributedText = NSAttributedString(string: text , attributes: hintTextAttributes)
        }
    }
    
    var rightSide: Bool? {
        willSet {
            guard let right = rightSide,
                  right else {
                hintLabel.textAlignment = .right
                return
            }
            hintLabel.textAlignment = .left
        }
    }
    
    public init(_ key: String, value: String, isEnabled: Bool, hint: String, rightView: Bool) {
        super.init(key, value: value, isEnabled: isEnabled, icon: nil)

        hintLabel.text = hint
        rightSide = rightView
        hintLabel.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        hintLabel.sizeToFit()
        addSubview(hintLabel)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        let width = bounds.width
        label.frame = CGRect(x: 0, y: 0, width: width/2, height: height - 7)
        field.frame = CGRect(x: width/2, y: 0, width: width/2, height: height - 7)
        
        guard let right = rightSide,
              right else {
            hintLabel.frame = CGRect(x: width/2, y: 15, width: width/2, height: bounds.height - 7)
            hintLabel.textAlignment = .right
            return
        }
        hintLabel.frame = CGRect(x: 0, y: 15, width: width/2, height: bounds.height - 7)
        hintLabel.textAlignment = .left
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
