//
//  KeySwitchField.swift
//  DARFormBuilder
//
//  Created by Apple on 1/26/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit


class KeySwitchField: UIView {
    
    let label = UILabel()
    let switchView = UISwitch()
    
    init(_ key: String, value: Bool = false) {
        super.init(frame: CGRect.zero)
        
        addSubview(label)
        addSubview(switchView)
        
        label.text = key
        switchView.isOn = value
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        switchView.frame = CGRect(x: bounds.width - switchView.frame.width, y: 0, width: switchView.frame.width, height: switchView.frame.height)
        label.frame = CGRect(x: 0, y: 0, width: switchView.frame.minX, height: bounds.height)
    }
}
