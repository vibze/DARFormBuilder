//
//  HeadingLabel.swift
//  DARFormBuilder
//
//  Created by Viktor Ten on 2/20/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit


/**
 Cell for displaying form headings. It has a title and a description.
 NSAttributedString is used under the bonnet.
 
 Example usage:
 
 ```
 let headingLabel = HeadingLabel(title: "Form", description: "Fill me!")
 ```
 */
open class HeadingLabel: UILabel, CanCalculateOwnHeight {
    
    open var height: CGFloat {
        let size = sizeThatFits(CGSize(width: frame.width, height: CGFloat.greatestFiniteMagnitude))
        return size.height + 5
    }
    
    public init(title: String, description: String) {
        super.init(frame: CGRect.zero)
        
        let text = NSMutableAttributedString()
        
        let titleText = NSAttributedString(string: title, attributes: [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 24),
            NSAttributedStringKey.foregroundColor: config.primaryTextColor
        ])
        
        let descriptionText = NSAttributedString(string: "\n\n" + description, attributes: [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13),
            NSAttributedStringKey.foregroundColor: config.labelTextColor
        ])
        
        if title != "" {
            text.append(titleText)
        }
        
        if description != "" {
            text.append(descriptionText)
        }
        
        numberOfLines = 0
        lineBreakMode = .byWordWrapping
        self.attributedText = text
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
