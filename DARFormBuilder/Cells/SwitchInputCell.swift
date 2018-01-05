//
//  SwitchInputCell.swift
//  DARFormBuilder
//
//  Created by Apple on 1/5/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit


class SwitchInputCell: BaseCell {
    
    var onValueChanged: ((Bool) -> Void)?
    
    var label = "" {
        didSet {
            labelLabel.text = label
        }
    }
    
    var value = false {
        didSet {
            switchView.isOn = value
        }
    }
    
    private var labelLabel = UILabel()
    private var switchView = UISwitch()
    
    override func configureSubviews() {
        labelLabel.numberOfLines = 0
        labelLabel.font = UIFont.systemFont(ofSize: 14)
        labelLabel.translatesAutoresizingMaskIntoConstraints = false
        
        switchView.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
        switchView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func addSubviews() {
        contentView.addSubview(labelLabel)
        contentView.addSubview(switchView)
    }
    
    override func configureConstraints() {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: labelLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: padding.left),
            NSLayoutConstraint(item: labelLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: padding.top),
            NSLayoutConstraint(item: labelLabel, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -padding.bottom)
            ])
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: switchView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: padding.top),
            NSLayoutConstraint(item: switchView, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -padding.right),
            NSLayoutConstraint(item: switchView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -padding.bottom)
            ])
    }
    
    @objc func valueChanged(_ sender: UISwitch) {
        onValueChanged?(sender.isOn)
    }
}
