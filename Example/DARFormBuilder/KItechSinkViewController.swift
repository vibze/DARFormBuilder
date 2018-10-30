//
//  KItechSinkViewController.swift
//  DARFormBuilder_Example
//
//  Created by admin on 10/11/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import DARFormBuilder


class KitchenSinkViewController: UIViewController {
    let formController = FormTableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addChildViewController(formController)
        view.addSubview(formController.tableView)
        formController.tableView.frame = view.bounds
        
        let headingLabel = HeadingLabel(title: "Flower order", description: "This is a demonstration of framework capabilities on a case of building flower delivery order form.")
        
        let dialField = KeyNumDialField("Number of flowers", value: 2, range: 0..<10)
        dialField.onNumberChange = { [weak self] (value: Int)  in
        }
        
        let verifyAddressByPhone = KeySwitchField("Verify address and delivery time by phone call")
        
        let keyValueWithImage = KeyValueField("Flower color", value: "blue", isEnabled: true, icon: #imageLiteral(resourceName: "priceTagIcon"))
     
        
        let sectionTitle = KeyValueField("Flower type", value: "rose", isEnabled: false)
        let switchValueWithImage = KeySwitchField("Verify address and delivery time by phone call", value: true, icon: #imageLiteral(resourceName: "priceTagIcon"))
        
        let options = SelectField.Option(text: "Tomato", value: "1")
        let selectionView = SelectField("Flower type", value: "room", options: [options], icon: #imageLiteral(resourceName: "priceTagIcon"))
        let verifyTime = KeySwitchField("Verify time")
        
        let streetField = TextInput("Street")
        streetField.isRequired = true
        
        
        let houseField = TextInput("House")
        houseField.isRequired = true

        let flatField = TextInput("Flat")
        let deliveryTimeField = DateInput("Delivery time and date", value: Date())
        
        let recipientNameField = TextInput("Recipient Name", isFloat: false)
        let recipientPhoneField = PhoneInput("Recipient Phone")
        let selectActionField = SelectFieldWithAction("Choose other")
        selectActionField.action = { action in
            // Do something
        }
        
      
        let hintLabel = HintLabel("Hint", rightView: true)
        let selectContact = PhoneInputWithActionButton(placeholder: "Phone number", icon: #imageLiteral(resourceName: "contactIcon"))
        selectContact.presentSelector = { [weak self] viewController in
            self?.present(viewController, animated: true, completion: nil)
        }
        
        let submitButton = UIButton()
        submitButton.backgroundColor = UIColor.black
        submitButton.setTitle("Place order", for: .normal)
        submitButton.addTarget(self, action: #selector(didTapSubmit), for: .touchUpInside)
        submitButton.frame = CGRect(x: 0, y: 0, width: 320, height: 44)
        
        formController.rows = [
            Row(headingLabel),
            Row(selectContact),
            Row(hintLabel, separate: true, separatorLeading: 16),
            Row(dialField),
            Divider(style: .stripe(height: 6)),
            Row(selectActionField),
            Row(sectionTitle),
            Row(selectionView),
            Row(keyValueWithImage),
            Row(switchValueWithImage),
            Divider(style: .stripe(height: 6)),
            Row(streetField),
            Row(verifyTime),
            Row(houseField, flatField),
            Divider(),
            Row(deliveryTimeField),
            Divider(style: .section(title: "Recipient", height: 30)),
            Row(recipientNameField),
            Row(recipientPhoneField),
            Divider(),
            Row(verifyAddressByPhone),
            Divider(style: .stripe(height: 10)),
            Row(submitButton)
        ]
    }
    
    @objc func didTapSubmit(_ sender: UIButton) {
        for field in formController.validatableFields {
            field.errors.isEmpty ? field.hideError() : field.showError()
        }
    }
}
