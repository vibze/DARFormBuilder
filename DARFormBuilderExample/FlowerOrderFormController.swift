//
//  FlowerOrderFormController.swift
//  DARFormBuilderExample
//
//  Created by Apple on 1/5/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit

class FlowerOrderFormController: UIViewController {
    
    let formController = FormTableViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = true
        
        view.addSubview(formController.tableView)
        formController.automaticallyAdjustsScrollViewInsets = false
        formController.tableView.frame = view.bounds
        
        let headingLabel = HeadingLabel(title: "Flower order", description: "This is a demonstration of framework capabilities on a case of building flower delivery order form.")
        
        // let selectField = Selectfield("Город")
        // selectField.collection = []
        
        let verifyAddressByPhone = KeySwitchField("Verify address and delivery time by phone call")
        
        let streetField = TextInput("Street")
        streetField.isRequired = true
        
        let houseField = TextInput("House")
        houseField.isRequired = true
        
        let flatField = TextInput("Flat")
        let deliveryTimeField = DateInput("Delivery time and date", value: Date())
        
        let recipientNameField = TextInput("Recipient Name")
        let recipientPhoneField = PhoneInput("Recipient Phone")
        
        let submitButton = UIButton()
        submitButton.backgroundColor = UIColor.black
        submitButton.setTitle("Place order", for: .normal)
        submitButton.addTarget(self, action: #selector(didTapSubmit), for: .touchUpInside)
        submitButton.frame = CGRect(x: 0, y: 0, width: 320, height: 44)

        formController.rows = [
            Row(headingLabel),
            Divider(style: .stripe(height: 6)),
            Row(streetField),
            Divider(),
            Row(houseField, flatField),
            Divider(),
            Row(deliveryTimeField),
            Divider(style: .stripe(height: 6)),
            Row(recipientNameField),
            Divider(),
            Row(recipientPhoneField),
            Divider(),
            Row(verifyAddressByPhone),
            Divider(style: .stripe(height: 10)),
            Row(submitButton)
        ]
    }
    
    func didTapSubmit(_ sender: UIButton) {
        for field in formController.validatableFields {
            field.errors.isEmpty ? field.hideError() : field.showError()
        }
    }
}