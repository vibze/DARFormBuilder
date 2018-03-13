//
//  KeyNumDialField.swift
//  DARFormBuilder
//
//  Created by Viktor Ten on 1/26/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit


public class KeyNumDialField: KeyValueField {
    
    public var onNumberChange: ((Int) -> Void)?
    public var intValue: Int = 0 {
        didSet {
            value = intValue.description
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
        
        self.intValue = value
        self.range = range
        
        addSubview(plusButton)
        addSubview(minusButton)
        
        plusButton.backgroundColor = UIColor.black.withAlphaComponent(0.03)
        plusButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 0)
        plusButton.setTitle("+", for: .normal)
        plusButton.setTitleColor(field.textColor, for: .normal)
        minusButton.backgroundColor = UIColor.black.withAlphaComponent(0.03)
        minusButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 0)
        minusButton.setTitle("–", for: .normal)
        minusButton.setTitleColor(field.textColor, for: .normal)
        
        field.keyboardType = .numberPad
        field.isEnabled = false
        
        plusButton.addTarget(self, action: #selector(didTapPlusButton), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(didTapMinusButton), for: .touchUpInside)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        plusButton.layer.cornerRadius = bounds.height/2
        plusButton.frame = CGRect(x: bounds.width - bounds.height, y: 0, width: bounds.height, height: bounds.height)
        
        field.sizeToFit()
        field.frame = CGRect(x: plusButton.frame.minX - field.frame.width - 9, y: 0, width: field.frame.width, height: bounds.height)
        
        minusButton.layer.cornerRadius = bounds.height/2
        minusButton.frame = CGRect(x: field.frame.minX - bounds.height - 5, y: 0, width: bounds.height, height: bounds.height)
    }
    
    func didTapPlusButton(_ sender: UIButton) {
        guard range.contains(intValue + 1) else { return }
        intValue += 1
        onNumberChange?(intValue)
    }
    
    func didTapMinusButton(_ sender: UIButton) {
        guard range.contains(intValue - 1) else { return }
        intValue -= 1
        onNumberChange?(intValue)
    }
}
