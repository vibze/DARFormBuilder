//
//  FloatLabelTextField.swift
//  DARFormBuilder
//
//  Created by Darkhan Mukatay on 24/01/2018.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit

class FloatLabelTextField: UITextField {

    let placeholderLabel = UILabel()

    var placeholderLabelTopConstraint: NSLayoutConstraint? = nil
    var config = Config()
    
    override var text: String? {
        didSet {
            let currentLength = text?.count ?? 0
            currentLength > 0 ? floatLabel() : groundLabel()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        configureSubviews()
        addSubviews()
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSubviews() {
        self.font = UIFont.systemFont(ofSize: config.fontSize)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        placeholderLabel.font = self.font
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addSubviews() {
        self.addSubview(placeholderLabel)
    }
    
    func configureConstraints() {
        placeholderLabelTopConstraint = NSLayoutConstraint(item: placeholderLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: placeholderLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0),
            placeholderLabelTopConstraint!
            ])
    }
    
    func floatLabel() {
        placeholderLabelTopConstraint?.constant = -14
        placeholderLabel.font = UIFont.systemFont(ofSize: 11)
        UIView.animate(withDuration: 0.1) {
            self.layoutIfNeeded()
        }
    }
    
    func groundLabel() {
        placeholderLabelTopConstraint?.constant = 0
        placeholderLabel.font = self.font
        UIView.animate(withDuration: 0.1) {
            self.layoutIfNeeded()
        }
    }
}
