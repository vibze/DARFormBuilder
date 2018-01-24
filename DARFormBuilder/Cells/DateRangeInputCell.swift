//
//  DateRangeInputCell.swift
//  DARFormBuilder
//
//  Created by Darkhan Mukatay on 24/01/2018.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit

public class DateRangeInputCell: BaseCell {

    var onChange: ((_ date: Date?, _ startTime: Date?, _ endTime: Date?) -> Void)?
    
    var datePlaceholder: String = ""
    var startTimePlaceholder: String = ""
    var endTimePlaceholder: String = ""

    let dateTextField = FloatLabelTextField()
    let startTimeTextField = FloatLabelTextField()
    let endTimeTextField = FloatLabelTextField()
    
    let stackView = UIStackView()
    
    var dateValue: Date? = nil {
        didSet {
            datePickerView.date = dateValue ?? Date()
            
            if let date = dateValue {
                dateTextField.text = dateFormatter.string(from: date)
            }
        }
    }
    
    var startTimeValue: Date? = nil {
        didSet {
            startTimePickerView.date = startTimeValue ?? Date()
            
            if let startTime = startTimeValue {
                startTimeTextField.text = timeFormatter.string(from: startTime)
            }
        }
    }
    
    var endTimeValue: Date? = nil {
        didSet {
            endTimePickerView.date = endTimeValue ?? Date()
            
            if let endTime = endTimeValue {
                endTimeTextField.text = timeFormatter.string(from: endTime)
            }
        }
    }
    
    private let datePickerView: UIDatePicker = UIDatePicker()
    private let startTimePickerView: UIDatePicker = UIDatePicker()
    private let endTimePickerView: UIDatePicker = UIDatePicker()
    private let dateFormatter = DateFormatter()
    private let timeFormatter = DateFormatter()
    
    public convenience init(datePlaceholder: String, startTimePlaceholder: String, endTimePlaceholder: String,
                            dateValue: Date?, startTimeValue: Date?, endTimeValue: Date?,
                            onChange: ((_ date: Date?, _ startTime: Date?, _ endTime: Date?) -> Void)?) {
        self.init(style: .default, reuseIdentifier: nil)
        self.datePlaceholder = datePlaceholder
        self.startTimePlaceholder = startTimePlaceholder
        self.endTimePlaceholder = endTimePlaceholder
        self.dateValue = dateValue
        self.startTimeValue = startTimeValue
        self.endTimeValue = endTimeValue
        self.onChange = onChange
    }
    
    override func configureSubviews() {
        stackView.axis  = .horizontal
        stackView.distribution  = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        dateFormatter.dateFormat = "dd.MM.yyyy"
        datePickerView.datePickerMode = .date
        dateTextField.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(pickerValueChanged), for: .valueChanged)
        
        timeFormatter.timeStyle = .short
        
        startTimePickerView.datePickerMode = .time
        startTimeTextField.inputView = startTimePickerView
        startTimePickerView.addTarget(self, action: #selector(pickerValueChanged), for: .valueChanged)
        
        endTimePickerView.datePickerMode = .time
        endTimeTextField.inputView = endTimePickerView
        endTimePickerView.addTarget(self, action: #selector(pickerValueChanged), for: .valueChanged)
    }
    
    override func addSubviews() {
        stackView.addArrangedSubview(dateTextField)
        stackView.addArrangedSubview(startTimeTextField)
        stackView.addArrangedSubview(endTimeTextField)
        contentView.addSubview(stackView)
    }
    
    override func configureConstraints() {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: stackView, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: padding.left),
            NSLayoutConstraint(item: stackView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: padding.top),
            NSLayoutConstraint(item: stackView, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: padding.right),
            NSLayoutConstraint(item: stackView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -padding.bottom)
            ])
    }
    
    @objc func pickerValueChanged(sender: UIDatePicker) {
        dateValue = datePickerView.date
        startTimeValue = startTimePickerView.date
        endTimeValue = endTimePickerView.date
        
        onChange?(dateValue, startTimeValue, endTimeValue)
    }

    override func configureCell() {
        datePickerView.date = dateValue ?? Date()
        startTimePickerView.date = startTimeValue ?? Date()
        endTimePickerView.date = endTimeValue ?? Date()
        
        if let date = dateValue {
            dateTextField.text = dateFormatter.string(from: date)
        }
        
        if let startTime = startTimeValue {
            startTimeTextField.text = timeFormatter.string(from: startTime)
        }
        
        if let endTime = endTimeValue {
            endTimeTextField.text = timeFormatter.string(from: endTime)
        }
        
        dateTextField.placeholderLabel.text = datePlaceholder
        startTimeTextField.placeholderLabel.text = startTimePlaceholder
        endTimeTextField.placeholderLabel.text = endTimePlaceholder
    }
}
