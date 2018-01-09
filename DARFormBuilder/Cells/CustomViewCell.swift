//
//  CustomViewCell.swift
//  DARFormBuilder
//
//  Created by Darkhan Mukatay on 08/01/2018.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit

class CustomViewCell: BaseCell {

    var customView = UIView() {
        didSet {
            cellView = customView
        }
    }
    
    private var cellView = UIView()

    override func configureSubviews() {
        cellView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func addSubviews() {
        contentView.addSubview(cellView)
    }
    
    override func configureConstraints() {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: cellView, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: cellView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: cellView, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: cellView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: 0)
        ])
    }
}
