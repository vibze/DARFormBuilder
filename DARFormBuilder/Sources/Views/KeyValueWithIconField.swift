//
//  KeyValueWithIconField.swift
//  DARFormBuilder
//
//  Created by Kamila Kusainova on 23.10.2018.
//

import UIKit

public class KeyValueWithIconField: KeyValueField {
    let iconImage = UIImageView()
    
    public init(_ key: String, value: String, isEnabled: Bool, icon: UIImage) {
        super.init(key, value: value, isEnabled: isEnabled)
        iconImage.image = icon
        addSubview(iconImage)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        iconImage.frame = CGRect(x: 0, y: 0, width: bounds.width/12, height: bounds.height)
        label.frame = CGRect(x: bounds.width/10, y: 0, width: bounds.width/2, height: bounds.height)
        field.frame = CGRect(x: bounds.width/2, y: 0, width: bounds.width/2, height: bounds.height)
    }
}
