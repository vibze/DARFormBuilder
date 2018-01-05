//
//  TitleCell.swift
//  DARFormBuilder
//
//  Created by Apple on 1/5/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit


/**
 Ячейка с названием формы.
 Большой черный шрифт.
 */
class TitleCell: BaseCell {
    
    var titleText = "" {
        didSet {
            titleLabel.text = titleText
        }
    }
    
    override var shouldHideSeparator: Bool {
        return true
    }
    
    override var padding: UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 17, bottom: 0, right: 15)
    }
    
    private let titleLabel = UILabel()
    
    override func configureSubviews() {
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textColor = UIColor.black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        separatorInset = UIEdgeInsets(top: 0, left: 320, bottom: 0, right: 0)
    }
    
    override func addSubviews() {
        contentView.addSubview(titleLabel)
    }
    
    override func configureConstraints() {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: padding.left),
            NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: padding.top),
            NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -padding.right),
            NSLayoutConstraint(item: titleLabel, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -padding.bottom)
            ])
    }
}
