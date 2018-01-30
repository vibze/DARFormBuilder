//
//  KeyNumDialField.swift
//  DARFormBuilder
//
//  Created by Apple on 1/26/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit


public class KeyNumDialField: KeyValueField {
    
    public var value: Int = 0 {
        didSet {
            field.text = value.description
            layoutSubviews()
        }
    }
    
    public override var canBecomeFirstResponder: Bool {
        return false
    }
    
    public var range: Range<Int> = 0..<100
    
    private let plusButton = UIButton()
    private let minusButton = UIButton()
    
    public init(_ key: String, value: Int = 0, range: Range<Int> = 0..<100) {
        super.init(key, value: "\(value)")
        
        self.value = value
        self.range = range
        
        plusButton.setTitle("+", for: .normal)
        plusButton.setTitleColor(field.textColor, for: .normal)
        minusButton.setTitle("–", for: .normal)
        minusButton.setTitleColor(field.textColor, for: .normal)
        
        field.leftView = minusButton
        field.leftViewMode = .always
        field.rightView = plusButton
        field.rightViewMode = .always
        field.keyboardType = .numberPad
        
        plusButton.addTarget(self, action: #selector(didTapPlusButton), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(didTapMinusButton), for: .touchUpInside)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        field.sizeToFit()
        field.frame.origin = CGPoint(x: bounds.width - field.frame.width, y: 0)
        plusButton.frame.size = CGSize(width: bounds.height, height: bounds.height)
        minusButton.frame.size = CGSize(width: bounds.height, height: bounds.height)
    }
    
    func didTapPlusButton(_ sender: UIButton) {
        guard range.contains(value + 1) else { return }
        value += 1
    }
    
    func didTapMinusButton(_ sender: UIButton) {
        guard range.contains(value - 1) else { return }
        value -= 1
    }
}
