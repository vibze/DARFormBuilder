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
        //formController.bottomInset = 100
        
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 400, height: 100))
        btn.setTitle("Validate form", for: .normal)
        btn.addTarget(self, action: #selector(validateForm), for: .touchUpInside)
        btn.backgroundColor = .blue
        btn.setTitleColor(.white, for: .normal)
        formController.tableView.tableFooterView = btn
        
        let usernameCell = TextFieldInputCell(placeholder: "Hi there", value: "Username", maxLength: 30) { text in
            print(text)
        }
        usernameCell.separatorStyle = .stripe
        
        formController.cells = [
            TitleCell(text: "Title", fontSize: 30),
            DescriptionCell(text: "Your top client is Ice Cream Shop, Inc. Their ice cream is so popular they can’t keep up with customer orders at the counter. They’ve recruited you to create a sleek iOS app that will allow customers to order ice cream right from their phone. You’ve started developing the app, and it’s coming along well.", fontSize: 12),
            StaticValueCell(label: "Price", value: "1000"),
            NumDialInputCell(label: "Amount", value: 5, range: 1..<25) { amount in
                print(amount)
            },
            TextInputCell(placeholder: "Letters, words") { text in
                print(text)
            },
            TextInputCell(placeholder: "Letters, words", value: "Hello", maxLength: 60) { text in
                print(text)
            },
            DateInputCell(placeholder: "Date", value: nil, pickerMode: .date, format: "dd.MM.yyyy", onChange: { (date) in
                print(date)
            }),
            DateInputCell(placeholder: "Time", value: nil, pickerMode: .time, format: "hh:mm", onChange: { (time) in
                print(time)
            }),
            SwitchInputCell(label: "Yes/No?", value: true) { value in
                print(value)
                if value {
                    self.formController.hiddenRows = [IndexPath.init(row: 2, section: 0)]
                }
                else {
                    self.formController.hiddenRows = []
                }
            },
            CustomViewCell(customView: UIImageView(image: #imageLiteral(resourceName: "randomImage"))),
            SwitchInputCell(label: "При звонке не сообщать, что это доставка цветов") { value in
                print(value)
            },
            ClickableCell(label: "Click me") {
                print("Clicked!")
            },
            TextFieldInputCell(placeholder: "Hi there", maxLength: 60) { text in
                print(text)
            },
            usernameCell,
            TextInputCell(placeholder: "Test me", value: "...", maxLength: 20) { text in
                print(text)
            },
 
            DateRangeInputCell(datePlaceholder: "Date", startTimePlaceholder: "Start", endTimePlaceholder: "End",
                               dateValue: nil, startTimeValue: nil, endTimeValue: nil,
                               onChange: { (date, startTime, endTime) in
                                guard let date = date, let startTime = startTime, let endTime = endTime else {
                                    return
                                }
                print(date)
                print(startTime)
                print(endTime)
            })
        ]
    }
    
    var err = false
    func validateForm() {
        print("validator")
        if err {
            formController.cells[4].showError()
            formController.cells[5].showError()
            err = false
        } else {
            formController.cells[4].hideError()
            formController.cells[5].hideError()
            err = true
        }
    }
}
