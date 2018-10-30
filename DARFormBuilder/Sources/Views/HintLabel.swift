//
//  HintLabel.swift
//  DARFormBuilder
//
//  Created by Kamila Kusainova on 29.10.2018.
//

import UIKit

public class HintLabel: UIView, CanCalculateOwnHeight {
    
    let hint = UILabel()
    
    var height: CGFloat {
        return 10
    }
    
    open var hintTextAttributes = [NSAttributedStringKey: Any]() {
        didSet {
            guard let text = hint.text else { return }
            hint.attributedText = NSAttributedString(string: text , attributes: hintTextAttributes)
        }
    }
    
    var rightSide: Bool? {
        willSet {
            guard let right = rightSide,
                  right else {
                hint.textAlignment = .right
                return
            }
            hint.textAlignment = .right
        }
    }
    
    public init(_ text: String, rightView: Bool) {
        super.init(frame: .zero)
        
        hint.text = text
        rightSide = rightView
 
        hint.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        addSubview(hint)
    }
    

    public override func layoutSubviews() {
        super.layoutSubviews()
        let width = bounds.width
   
        guard let right = rightSide,
              right else {
                hint.frame = CGRect(x: 0, y: -5, width: width/2, height: height)
                hint.textAlignment = .left
            return
        }
        hint.frame = CGRect(x: width/2, y: -5, width: width/2, height: height)
        hint.textAlignment = .right
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
