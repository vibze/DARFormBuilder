//
//  ViewController.swift
//  DARFormBuilderExample
//
//  Created by Apple on 1/5/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FormControllerDataSource, FormControllerDelegate {
    
    let formController = FormController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(formController.view)
        formController.view.frame = view.bounds
        
        formController.items = [
            .title(text: "Title"),
            .description(text: "Your top client is Ice Cream Shop, Inc. Their ice cream is so popular they can’t keep up with customer orders at the counter. They’ve recruited you to create a sleek iOS app that will allow customers to order ice cream right from their phone. You’ve started developing the app, and it’s coming along well."),
            .staticValue(label: "Price", value: "1000"),
            .numDialInput(label: "Amount", key: "amount"),
            .textInput(label: "Name", placeholder: "Letters, words", keyboardType: .default, key: "name"),
            .dateInput(label: "Birthday", placeholder: "xx/xx/xxxx", key: "birthday"),
            .switchInput(label: "Yes/No?", key: "yesno")
        ]
        formController.delegate = self
        formController.dataSource = self
    }
    
    
    // MARK: FormControllerDataSource
    
    func formController(_ formController: FormController, intValueForKey key: String) -> Int? {
        switch key {
        case "amount": return 10
        default: return 10
        }
    }
    
    func formController(_ formController: FormController, dateValueForKey key: String) -> Date? {
        switch key {
        case "birthday": return Date(timeIntervalSince1970: 20)
        default: return Date()
        }
    }
    
    func formController(_ formController: FormController, boolValueForKey key: String) -> Bool? {
        switch key {
        case "yesno": return true
        default: return false
        }
    }
    
    func formController(_ formController: FormController, stringValueForKey key: String) -> String? {
        switch key {
        case "name": return "XYU"
        default: return ""
        }
    }
    
    
    // MARK: FormControllerDelegate
    
    func formController(_ formController: FormController, didChangeIntValueForKey key: String, value: Int) {
        print("\(key): \(value)")
    }
    
    func formController(_ formController: FormController, didChangeStringValueForKey key: String, value: String) {
        print("\(key): \(value)")
    }
    
    func formController(_ formController: FormController, didChangeBoolValueForKey key: String, value: Bool) {
        print("\(key): \(value)")
    }
    
    func formController(_ formController: FormController, didChangeDateValueForKey key: String, value: Date) {
        print("\(key): \(value)")
    }
}

