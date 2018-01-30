//
//  DateField.swift
//  DARFormBuilder
//
//  Created by Viktor Ten on 1/26/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit


/**
 Date/Time input based on `StringField`.
 
 
 ## Properties in addition to StringField
 
 `onDateChange` - Callback for date value change
 
 `datePickerMode` - `UIDatePicker` date picker mode enum
 
 `maxDate` - Maximum date that will be allowed in datePicker
 
 `minDate` - Minimum date that will be allowed in datePicker
 
 `date` - Date value of the field
 
 `dateFormat` - String representation of date that will be displayed in the field
 
 */
public class DateField: StringField {
    
    public var onDateChange: ((Date) -> Void)?
    
    public var datePickerMode: UIDatePickerMode {
        get { return datePicker.datePickerMode }
        set (v) { datePicker.datePickerMode = v }
    }
    
    public var maxDate: Date? {
        get { return datePicker.maximumDate }
        set (v) { datePicker.maximumDate = v }
    }
    
    public var minDate: Date? {
        get { return datePicker.minimumDate }
        set (v) { datePicker.minimumDate = v }
    }
    
    public var date: Date {
        get { return datePicker.date }
        set (v) {
            datePicker.date = v
            text = dateFormatter.string(from: v)
        }
    }
    
    public var dateFormat: String {
        get { return dateFormatter.dateFormat }
        set (v) { dateFormatter.dateFormat = v }
    }
    
    private let datePicker = UIDatePicker()
    private let dateFormatter = DateFormatter()
    
    public init(_ placeholder: String = "", value: Date?) {
        super.init(placeholder, maxLength: 0)
        
        datePickerMode = .dateAndTime
        inputView = datePicker
        dateFormat = "dd.MM.yyyy HH:mm"
        
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func datePickerValueChanged(_ sender: UIDatePicker) {
        date = sender.date
        onDateChange?(date)
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        date = datePicker.date
    }
}
