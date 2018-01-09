//
//  DateInputCell.swift
//  DARFormBuilder
//
//  Created by Apple on 1/5/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit


public class DateInputCell: TextInputCell {
    
    var onDateChange: ((Date) -> Void)?
    
    var dateValue: Date? = nil {
        didSet {
            datePickerView.date = dateValue ?? Date()
            
            if let date = dateValue {
                textView.text = dateFormatter.string(from: date)
            }
        }
    }
    
    private let datePickerView: UIDatePicker = UIDatePicker()
    private let dateFormatter = DateFormatter()
    
    public convenience init(value: Date? = nil, onChange: ((Date) -> Void)?) {
        self.init(style: .default, reuseIdentifier: nil)
        dateValue = value
        onDateChange = onChange
    }

    override func configureSubviews() {
        super.configureSubviews()
        
        dateFormatter.dateFormat = "HH:mm DD/MM/YYYY"
        
        datePickerView.datePickerMode = .dateAndTime
        textView.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
    }
    
    @objc func datePickerValueChanged(sender: UIDatePicker) {
        dateValue = sender.date
        
        if let date = dateValue {
            onDateChange?(date)
            placeholderLabel.isHidden = true
        }
    }
    
    override func configureCell() {
        super.configureCell()
        datePickerView.date = dateValue ?? Date()
        
        if let date = dateValue {
            textView.text = dateFormatter.string(from: date)
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        datePickerValueChanged(sender: datePickerView)
    }
}
