//
//  DescriptionCell.swift
//  DARFormBuilder
//
//  Created by Apple on 1/5/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit


/**
 Ячейка с описанием.
 Мелкий серый текст.
 */
public class DescriptionCell: BaseCell {
    
    var descText = ""
    
    private let descriptionLabel = UILabel()
    
    public convenience init(text: String, fontSize: CGFloat = 12) {
        self.init(style: .default, reuseIdentifier: nil)
        descText = text
        descriptionLabel.font = UIFont.systemFont(ofSize: fontSize)
    }
    
    override func configureSubviews() {
        descriptionLabel.textColor = UIColor.lightGray
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func addSubviews() {
        contentView.addSubview(descriptionLabel)
    }
    
    override func configureConstraints() {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: descriptionLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: padding.left),
            NSLayoutConstraint(item: descriptionLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: padding.top),
            NSLayoutConstraint(item: descriptionLabel, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -padding.right),
            NSLayoutConstraint(item: descriptionLabel, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -padding.bottom)
            ])
    }
    
    override func configureCell() {
        descriptionLabel.text = descText
    }
}
