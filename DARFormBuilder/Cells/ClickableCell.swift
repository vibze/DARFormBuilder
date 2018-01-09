//
//  ClickableCell.swift
//  DARFormBuilder
//
//  Created by Darkhan Mukatay on 08/01/2018.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit

public class ClickableCell: BaseCell {
    
    var label = ""
    var onTap: (() -> ())?
    
    private var labelLabel = UILabel()
    
    public convenience init(label: String, onTap: (() -> ())?) {
        self.init(style: .default, reuseIdentifier: nil)
        self.label = label
        self.onTap = onTap
        accessoryType = .disclosureIndicator
        selectionStyle = .default
    }
    
    override func configureSubviews() {
        labelLabel.font = UIFont.systemFont(ofSize: 14)
        labelLabel.textColor = UIColor.black
        labelLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let tgs = UITapGestureRecognizer(target: self, action: #selector(didTap))
        contentView.addGestureRecognizer(tgs)
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
    
    @objc func didTap() {
        onTap?()
    }
    
    override func configureCell() {
        labelLabel.text = label
    }
}
