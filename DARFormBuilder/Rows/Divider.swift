//
//  Divider.swift
//  DARFormBuilder
//
//  Created by Apple on 2/15/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit


public class Divider: UITableViewCell {
    
    public enum Style {
        case hairline
        case stripe(height: CGFloat)
    }
    
    var style: Style
    private let dividerView = UIView()
    
    public var height: CGFloat {
        switch style {
        case .hairline: return 1
        case .stripe(let height): return height
        }
    }
    
    public init(style: Style = .hairline) {
        self.style = style
        super.init(style: .default, reuseIdentifier: nil)
        
        addSubview(dividerView)
        dividerView.backgroundColor = config.separatorColor
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        switch style {
        case .hairline: dividerView.frame = CGRect(x: 16, y: 0, width: frame.width, height: self.height)
        case .stripe: dividerView.frame = CGRect(x: 0, y: 0, width: frame.width, height: self.height)
        }
    }
}
