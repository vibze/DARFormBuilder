//
//  DateInput.swift
//  DARFormBuilder
//
//  Created by Viktor Ten on 1/26/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit


/**
 Date/Time input based on `TextInput`.
 
 
 ## Properties in addition to TextInput
 
 `onDateChange` - Callback for date value change
 
 `datePickerMode` - `UIDatePicker` date picker mode enum
 
 `maxDate` - Maximum date that will be allowed in datePicker
 
 `minDate` - Minimum date that will be allowed in datePicker
 
 `date` - Date value of the field
 
 `dateFormat` - String representation of date that will be displayed in the field
 
 */
open class DateInput: TextInput {
    
    public var onDateChange: ((Date) -> Void)?
    
    open var datePickerMode: UIDatePickerMode {
        get { return datePicker.datePickerMode }
        set (v) { datePicker.datePickerMode = v }
    }
    
    open var maxDate: Date? {
        get { return datePicker.maximumDate }
        set (v) { datePicker.maximumDate = v }
    }
    
    open var minDate: Date? {
        get { return datePicker.minimumDate }
        set (v) { datePicker.minimumDate = v }
    }
    
    open var date: Date? = nil {
        didSet {
            if let date = date {
                datePicker.date = date ?? Date()
                text = dateFormatter.string(from: date)
            }
        }
    }
    
    open var dateFormat: String {
        get { return dateFormatter.dateFormat }
        set (v) {
            dateFormatter.dateFormat = v
            if let date = date {
                text = dateFormatter.string(from: date)
            }
        }
    }
    
    private let datePicker = UIDatePicker()
    private let dateFormatter = DateFormatter()
    
    public init(_ placeholder: String = "", value: Date?) {
        super.init(placeholder)
        
        datePickerMode = .dateAndTime
        textField.inputView = datePicker
        dateFormat = "dd.MM.yyyy HH:mm"
        
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        
        if let date = value {
            self.date = date
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc open func datePickerValueChanged(_ sender: UIDatePicker) {
        date = sender.date
        onDateChange?(sender.date)
    }
    
    open func textFieldDidBeginEditing(_ textField: UITextField) {
        date = datePicker.date
        onDateChange?(datePicker.date)
    }
}
