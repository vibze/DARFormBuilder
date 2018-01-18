//
//  NumDialInputCell.swift
//  DARFormBuilder
//
//  Created by Apple on 1/5/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit


public class NumDialInputCell: BaseCell {
    
    var label = ""
    
    var value: Int = 0 {
        didSet {
            valueLabel.text = value.description
        }
    }
    
    var range: Range<Int> = 0..<100
    
    var onValueChanged: ((Int) -> Void)? = nil
    
    private var buttonSize: CGFloat = 30
    private let labelLabel = UILabel()
    private let valueLabel = UILabel()
    private let plusButton = UIButton()
    private let minusButton = UIButton()
    
    public convenience init(label: String, value: Int = 0, range: Range<Int> = 0..<100, onChange: ((Int) -> Void)?) {
        self.init(style: .default, reuseIdentifier: nil)
        self.label = label
        self.value = value
        self.range = range
        onValueChanged = onChange
    }
    
    override func configureSubviews() {
        labelLabel.font = UIFont.systemFont(ofSize: config.fontSize)
        labelLabel.textColor = UIColor.black
        labelLabel.translatesAutoresizingMaskIntoConstraints = false
        
        plusButton.addTarget(self, action: #selector(didTapPlusButton), for: .touchUpInside)
        plusButton.setTitle("+", for: .normal)
        plusButton.setTitleColor(UIColor.black, for: .normal)
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        
        valueLabel.font = UIFont.systemFont(ofSize: config.fontSize)
        valueLabel.textColor = UIColor.black
        valueLabel.textAlignment = .right
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        minusButton.addTarget(self, action: #selector(didTapMinusButton(_:)), for: .touchUpInside)
        minusButton.setTitle("–", for: .normal)
        minusButton.setTitleColor(UIColor.black, for: .normal)
        minusButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func addSubviews() {
        contentView.addSubview(labelLabel)
        contentView.addSubview(plusButton)
        contentView.addSubview(valueLabel)
        contentView.addSubview(minusButton)
    }
    
    override func configureConstraints() {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: labelLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: padding.left),
            NSLayoutConstraint(item: labelLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: padding.top),
            NSLayoutConstraint(item: labelLabel, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -padding.right),
            NSLayoutConstraint(item: labelLabel, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -padding.bottom),
            ])
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: plusButton, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: 10-padding.right),
            NSLayoutConstraint(item: plusButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30),
            NSLayoutConstraint(item: plusButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30),
            NSLayoutConstraint(item: plusButton, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: 0)
            ])
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: valueLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: padding.top),
            NSLayoutConstraint(item: valueLabel, attribute: .trailing, relatedBy: .equal, toItem: plusButton, attribute: .leading, multiplier: 1, constant: -5),
            NSLayoutConstraint(item: valueLabel, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -padding.bottom)
            ])
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: minusButton, attribute: .trailing, relatedBy: .equal, toItem: valueLabel, attribute: .leading, multiplier: 1, constant: -5),
            NSLayoutConstraint(item: minusButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30),
            NSLayoutConstraint(item: minusButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30),
            NSLayoutConstraint(item: minusButton, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: 0)
            ])
    }

    @objc func didTapPlusButton(_ sender: UIButton) {
        guard range.contains(value + 1) else { return }
        value += 1
        onValueChanged?(value)
    }
    
    @objc func didTapMinusButton(_ sender: UIButton) {
        guard range.contains(value - 1) else { return }
        value -= 1
        onValueChanged?(value)
    }
    
    override func configureCell() {
        labelLabel.text = label
        valueLabel.text = value.description
    }
}
