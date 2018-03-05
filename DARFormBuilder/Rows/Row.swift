//
//  Row.swift
//  DARFormBuilder
//
//  Created by Apple on 1/26/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit


public class Row: UITableViewCell {
    
    let stackView = UIStackView()
    let views: [UIView]
    var height: CGFloat {
        var subviewHeights: [CGFloat] = []
        
        stackView.frame = UIEdgeInsetsInsetRect(contentView.bounds, padding)
        stackView.layoutSubviews()

        for view in stackView.arrangedSubviews {
            if let view = view as? CanCalculateOwnHeight {
                subviewHeights.append(view.height + padding.top + padding.bottom)
            }
            else {
                subviewHeights.append(24 + padding.top + padding.bottom)
            }
        }
        return subviewHeights.max() ?? 50
    }
    
    public var fields: [UIView] {
        return stackView.arrangedSubviews
    }
    
    public var hasVisibleFields: Bool {
        for field in fields {
            if !field.isHidden {
                return true
            }
        }
        
        return false
    }
    
    private var padding: UIEdgeInsets {
        return Config().cellPadding
    }

    public convenience init(_ views: UIView...) {
        self.init(views)
    }
    
    public init(_ views: [UIView]) {
        self.views = views
        super.init(style: .default, reuseIdentifier: nil)
        
        contentView.addSubview(stackView)
        stackView.backgroundColor = UIColor.red
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.axis = .horizontal
        selectionStyle = .none
        
        for view in views {
            stackView.addArrangedSubview(view)
        }
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = UIEdgeInsetsInsetRect(contentView.bounds, padding)
    }
}

