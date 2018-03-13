//
//  KeySwitchField.swift
//  DARFormBuilder
//
//  Created by Viktor Ten on 1/26/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit


public class KeySwitchField: UIView, CanCalculateOwnHeight {
    
    let label = UILabel()
    let switchView = UISwitch()
    
    public var onChange: ((Bool) -> Void)?
    
    public init(_ key: String, value: Bool = false) {
        super.init(frame: CGRect.zero)
        
        addSubview(label)
        addSubview(switchView)
        
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = key
        switchView.isOn = value
        switchView.addTarget(self, action: #selector(switchDidChange), for: .valueChanged)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        switchView.frame = CGRect(x: bounds.width - switchView.frame.width, y: 0, width: switchView.frame.width, height: switchView.frame.height)
        label.frame = CGRect(x: 0, y: 0, width: switchView.frame.minX, height: bounds.height)
    }
    
    func switchDidChange(_ sender: UISwitch) {
        onChange?(sender.isOn)
    }
    
    var height: CGFloat {
        let size = label.sizeThatFits(CGSize(width: bounds.width - switchView.frame.width, height: CGFloat.greatestFiniteMagnitude))
        return max(size.height, switchView.frame.height)
    }
}
