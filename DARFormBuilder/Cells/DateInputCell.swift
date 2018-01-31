//
//  DateInputCell.swift
//  DARFormBuilder
//
//  Created by Apple on 1/5/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit


public class DateInputCell: TextFieldInputCell {
    
    var onDateChange: ((Date) -> Void)?
    
    var dateValue: Date? = nil {
        didSet {
            datePickerView.date = dateValue ?? Date()
            
            if let date = dateValue {
                textField.text = dateFormatter.string(from: date)
            }
        }
    }
    
    private let datePickerView: UIDatePicker = UIDatePicker()
    private let dateFormatter = DateFormatter()
    
    public convenience init(placeholder: String, value: Date?, pickerMode: UIDatePickerMode = .date,format: String = "dd.MM.yyyy", minimumDate: Date = Date(),onChange: ((Date) -> Void)?) {
        self.init(style: .default, reuseIdentifier: nil)
        self.placeholder = placeholder
        dateFormatter.dateFormat = format
        datePickerView.datePickerMode = pickerMode
        datePickerView.minimumDate = minimumDate
        
        dateValue = value
        onDateChange = onChange
    }

    override func configureSubviews() {
        super.configureSubviews()
        

        textField.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
    }
    
    @objc func datePickerValueChanged(sender: UIDatePicker) {
        dateValue = sender.date
        
        if let date = dateValue {
            onDateChange?(date)
            floatLabel()
        }
        else {
            groundLabel()
        }
    }
    
    override func configureCell() {
        super.configureCell()
        datePickerView.date = dateValue ?? Date()
        
        if let date = dateValue {
            textField.text = dateFormatter.string(from: date)
            floatLabel()
        }
        else {
            groundLabel()
        }
    }
    
    public override func textFieldDidBeginEditing(_ textField: UITextField) {
        super.textFieldDidBeginEditing(textField)
        datePickerValueChanged(sender: datePickerView)
    }
    
    override public func showError() {
        placeholderLabel.textColor = .red
    }
    
    override public func hideError() {
        placeholderLabel.textColor = .lightGray
    }
}
