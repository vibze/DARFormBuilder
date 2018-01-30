//
//  Row.swift
//  DARFormBuilder
//
//  Created by Apple on 1/26/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit


class Row: UITableViewCell, CanBeAskedToChangeHeight {
    
    weak var delegate: RowDelegate?
    
    let stackView = UIStackView()
    let views: [UIView]
    var height: CGFloat = 50
    
    private var padding: UIEdgeInsets {
        return Config().cellPadding
    }

    init(_ views: UIView...) {
        self.views = views
        super.init(style: .default, reuseIdentifier: nil)
        
        contentView.addSubview(stackView)
        stackView.backgroundColor = UIColor.red
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.axis = .horizontal
        for view in views {
            stackView.addArrangedSubview(view)
            if let view = view as? CanAskParentToChangeHeight {
                view.heightChangeDelegate = self
            }
        }
        
        selectionStyle = .none
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = UIEdgeInsetsInsetRect(contentView.bounds, padding)
    }
    
    func changeHeight(to height: CGFloat) {
        self.height = height
        delegate?.row(self, didChangeHeight: height + padding.top + padding.bottom)
    }
}


protocol RowDelegate: class {
    func row(_ row: Row, didChangeHeight height: CGFloat)
}
