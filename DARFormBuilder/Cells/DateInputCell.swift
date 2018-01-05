//
//  DateInputCell.swift
//  DARFormBuilder
//
//  Created by Apple on 1/5/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit


class DateInputCell: TextInputCell {
    
    var onDateChange: ((Date) -> Void)?
    
    var dateValue = Date() {
        didSet {
            datePickerView.date = dateValue
            textValue = dateFormatter.string(from: dateValue)
        }
    }
    
    private let datePickerView: UIDatePicker = UIDatePicker()
    private let dateFormatter = DateFormatter()

    override func configureSubviews() {
        super.configureSubviews()
        
        dateFormatter.dateFormat = "HH:mm DD/MM/YYYY"
        
        datePickerView.datePickerMode = .dateAndTime
        textField.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
    }
    
    @objc func datePickerValueChanged(sender: UIDatePicker) {
        dateValue = sender.date
        onDateChange?(dateValue)
    }
}
