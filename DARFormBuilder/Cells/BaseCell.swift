//
//  BaseCell.swift
//  DARFormBuilder
//
//  Created by Apple on 1/5/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit

protocol FormBuilderCellDelegate: class {
    func formBuilderCellDidUpdateHeight()
    func formBuilderCellScrollToCell(_ cell: BaseCell)
    func formBuilderCellNextFocusableCell(_ cell: BaseCell) -> BaseCell?
    func formBuilderCellPrevFocusableCell(_ cell: BaseCell) -> BaseCell?
    var formBuilderCellConfig: Config { get }
}

open class BaseCell: UITableViewCell {
    
    public enum SeparatorStyle {
        case hairline, stripe, none
    }
    
    var padding: UIEdgeInsets {
        return config.cellPadding
    }
    
    public var separatorStyle: SeparatorStyle = .hairline
    
    var shouldHideSeparator: Bool {
        return false
    }
    
    open override var canBecomeFocused: Bool {
        return false
    }
    
    weak var delegate: FormBuilderCellDelegate?
    
    var config: Config {
        return delegate?.formBuilderCellConfig ?? Config()
    }
    
    private let separator = CALayer()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        layer.addSublayer(separator)
        separator.backgroundColor = config.separatorColor.cgColor
        
        configureSubviews()
        addSubviews()
        configureConstraints()
        
        let tgs = UITapGestureRecognizer(target: self, action: #selector(didTapCell))
        addGestureRecognizer(tgs)
        
        clipsToBounds = true
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()

        switch separatorStyle {
        case .none: separator.frame = CGRect.zero
        case .hairline: separator.frame = CGRect(x: padding.left, y: frame.height - 1, width: frame.width - padding.left - padding.right, height: 1)
        case .stripe: separator.frame = CGRect(x: padding.left, y: frame.height - 5, width: frame.width - padding.left - padding.right, height: 5)
        }
    }
    
    func didTapCell(_ recognizer: UITapGestureRecognizer) {
        focus()
    }
    
    func configureSubviews() {
        
    }
    
    func addSubviews() {
        
    }
    
    func configureConstraints() {
        
    }
    
    func configureCell() {
        
    }
    
    func focus() {
        
    }
    
    func blur() {
        
    }
}
