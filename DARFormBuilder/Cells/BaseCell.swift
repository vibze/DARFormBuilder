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
}

public class BaseCell: UITableViewCell {
    
    var padding: UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 17, bottom: 10, right: 15)
    }
    
    var shouldHideSeparator: Bool {
        return false
    }
    
    public override var canBecomeFocused: Bool {
        return false
    }
    
    weak var delegate: FormBuilderCellDelegate?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        configureSubviews()
        addSubviews()
        configureConstraints()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if shouldHideSeparator {
            separatorInset = UIEdgeInsets(top: 0, left: frame.width, bottom: 0, right: 0)
        }
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
