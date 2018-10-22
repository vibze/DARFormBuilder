//
//  SectionDivider.swift
//  DARFormBuilder
//
//  Created by Vadim on 3/5/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import Foundation
import UIKit

final class SectionDivider: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    init(title: String?) {
        super.init(frame: .zero)
        titleLabel.text = title
        titleLabel.textColor = #colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1)
        addSubview(titleLabel)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let leadingOffset: CGFloat = 16
        titleLabel.frame = CGRect(x: leadingOffset, y: 0, width: frame.width - leadingOffset, height: frame.height)
    }
    
}
