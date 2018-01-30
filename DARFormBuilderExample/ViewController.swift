//
//  ViewController.swift
//  DARFormBuilderExample
//
//  Created by Apple on 1/5/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let formController = FormController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(formController.view)
        formController.view.frame = view.bounds
        
        let titleView = UILabel()
        titleView.text = "Тест"
        titleView.font = UIFont.systemFont(ofSize: 24)
        
        let nameField = StringField("Имя", maxLength: 60)
        nameField.onTextChange = { print($0) }
        let ageField = KeyValueField("Возраст", value: "10")
        let ageFixField = KeyValueField("Возраст (фикс)", value: "10")
        ageFixField.isEnabled = false
        
        let amountField = KeyNumDialField("Количеситво", value: 5)
        let boolField = KeySwitchField("Показать поля", value: true)
        
        let dateField = DateField("День рождения", value: nil)
        dateField.onDateChange = { print($0) }
        
        let fromTimeField = DateField("Время от", value: nil)
        fromTimeField.dateFormat = "HH:mm"
        fromTimeField.datePickerMode = .time
        
        let toTimeField = DateField("Время до", value: nil)
        toTimeField.dateFormat = "HH:mm"
        toTimeField.datePickerMode = .time
        
        let aboutField = TextField("Об Алексее могучем...", maxLength: 150)
        
        formController.rows = [
            Row(titleView),
            Row(nameField),
            Row(ageField),
            Row(ageFixField),
            Row(amountField),
            Row(boolField),
            Row(aboutField),
            Row(dateField),
            Row(fromTimeField, toTimeField),
        ]
    }
}
