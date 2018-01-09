//
//  AccessoryTypeCell.swift
//  DARFormBuilder
//
//  Created by Darkhan Mukatay on 08/01/2018.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit

class AccessoryTypeCell: BaseCell {
    
    var label = "" {
        didSet {
            labelLabel.text = label
        }
    }
    
    private var labelLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func configureSubviews() {
        labelLabel.font = UIFont.systemFont(ofSize: 14)
        labelLabel.textColor = UIColor.black
        labelLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func addSubviews() {
        contentView.addSubview(labelLabel)
    }
    
    override func configureConstraints() {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: labelLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: padding.left),
            NSLayoutConstraint(item: labelLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: padding.top),
            NSLayoutConstraint(item: labelLabel, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -padding.right),
            NSLayoutConstraint(item: labelLabel, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -padding.bottom)
        ])
    }
}
