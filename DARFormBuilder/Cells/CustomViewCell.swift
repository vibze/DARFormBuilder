//
//  CustomViewCell.swift
//  DARFormBuilder
//
//  Created by Darkhan Mukatay on 08/01/2018.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit

public class CustomViewCell: BaseCell {

    var customView = UIView()
    
    public convenience init(customView: UIView) {
        self.init(style: .default, reuseIdentifier: nil)
        self.customView = customView
    }
    
    override func configureCell() {
        customView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(customView)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: customView, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: customView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: customView, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: customView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: 0)
            ])
    }
}
