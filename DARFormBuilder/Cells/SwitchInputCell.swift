//
//  SwitchInputCell.swift
//  DARFormBuilder
//
//  Created by Apple on 1/5/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit


public class SwitchInputCell: BaseCell {
    
    var onValueChanged: ((Bool) -> Void)?
    
    var label = ""
    var value = false
    
    private var labelLabel = UILabel()
    private var switchView = UISwitch()
    
    public convenience init(label: String, value: Bool = false, onChange: ((Bool) -> Void)?) {
        self.init(style: .default, reuseIdentifier: nil)
        self.label = label
        self.value = value
        onValueChanged = onChange
    }
    
    override func configureSubviews() {
        labelLabel.numberOfLines = 0
        labelLabel.font = UIFont.systemFont(ofSize: config.fontSize)
        labelLabel.textColor = config.primaryTextColor
        labelLabel.translatesAutoresizingMaskIntoConstraints = false
        labelLabel.lineBreakMode = .byWordWrapping
        
        switchView.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
        switchView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func addSubviews() {
        contentView.addSubview(labelLabel)
        contentView.addSubview(switchView)
    }
    
    override func configureConstraints() {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: switchView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: padding.top),
            NSLayoutConstraint(item: switchView, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -padding.right),
            NSLayoutConstraint(item: switchView, attribute: .bottom, relatedBy: .lessThanOrEqual, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -padding.bottom)
            ])
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: labelLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: padding.left),
            NSLayoutConstraint(item: labelLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: padding.top),
            NSLayoutConstraint(item: labelLabel, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -padding.bottom),
            NSLayoutConstraint(item: labelLabel, attribute: .trailing, relatedBy: .equal, toItem: switchView, attribute: .leading, multiplier: 1, constant: -5)
            ])
        
    }
    
    @objc func valueChanged(_ sender: UISwitch) {
        onValueChanged?(sender.isOn)
        value = sender.isOn
    }
    
    override func configureCell() {
        labelLabel.text = label
        switchView.isOn = value
    }
}
