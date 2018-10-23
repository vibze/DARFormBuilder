//
//  KeySwitchFieldWithIcon.swift
//  DARFormBuilder
//
//  Created by Kamila Kusainova on 23.10.2018.
//

import UIKit

public class KeySwitchFieldWithIcon: KeySwitchField {
    let iconImage = UIImageView()
    
    public init(_ key: String, value: Bool, icon: UIImage) {
        super.init(key, value: value)
        
        iconImage.image = icon
        addSubview(iconImage)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        switchView.frame = CGRect(x: bounds.width - switchView.frame.width, y: 0, width: switchView.frame.width, height: switchView.frame.height)
        iconImage.frame = CGRect(x: 0, y: 0, width: bounds.width/12, height: bounds.height)
        label.frame = CGRect(x: bounds.width/10, y: 0, width: switchView.frame.minX, height: bounds.height)
    }
}
