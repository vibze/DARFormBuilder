//
//  StaticValueCell.swift
//  DARFormBuilder
//
//  Created by Apple on 1/5/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit


/**
 Ячейка с лейблом слева и статичным текстом справа
 */
public class StaticValueCell: BaseCell {
    
    var label = "" {
        didSet {
            labelLabel.text = label
        }
    }
    
    var value = "" {
        didSet {
            valueLabel.text = value
        }
    }

    private let labelLabel = UILabel()
    private let valueLabel = UILabel()
    
    public convenience init(label: String, value: String) {
        self.init(style: .default, reuseIdentifier: nil)
        self.label = label
        self.value = value
    }
    
    override func configureSubviews() {
        labelLabel.font = UIFont.systemFont(ofSize: 16)
        labelLabel.textColor = Config.primaryTextColor
        labelLabel.translatesAutoresizingMaskIntoConstraints = false
        
        valueLabel.font = UIFont.systemFont(ofSize: 16)
        valueLabel.textColor = Config.primaryTextColor
        valueLabel.textAlignment = .right
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func addSubviews() {
        contentView.addSubview(labelLabel)
        contentView.addSubview(valueLabel)
    }
    
    override func configureConstraints() {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: labelLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: padding.left),
            NSLayoutConstraint(item: labelLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: padding.top),
            NSLayoutConstraint(item: labelLabel, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -padding.bottom)
            ])
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: valueLabel, attribute: .leading, relatedBy: .equal, toItem: labelLabel, attribute: .trailing, multiplier: 1, constant: 15),
            NSLayoutConstraint(item: valueLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: padding.top),
            NSLayoutConstraint(item: valueLabel, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -padding.right),
            NSLayoutConstraint(item: valueLabel, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -padding.bottom)
            ])
    }
    
    override func configureCell() {
        labelLabel.text = label
        valueLabel.text = value
    }
}

