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
        
        formController.cells = [
            TitleCell(text: "Title", fontSize: 30),
            DescriptionCell(text: "Your top client is Ice Cream Shop, Inc. Their ice cream is so popular they can’t keep up with customer orders at the counter. They’ve recruited you to create a sleek iOS app that will allow customers to order ice cream right from their phone. You’ve started developing the app, and it’s coming along well.", fontSize: 12),
            StaticValueCell(label: "Price", value: "1000"),
            NumDialInputCell(label: "Amount", value: 5, range: 1..<25) { amount in
                print(amount)
            },
            TextInputCell(placeholder: "Letters, words", keyboardType: .default, maxLength: 60) { text in
                print(text)
            },
            DateInputCell(placeholder: "Date") { date in
                print(date)
            },
            SwitchInputCell(label: "Yes/No?", value: true) { value in
                print(value)
            },
            ClickableCell(label: "Click me") {
                print("Clicked!")
            },
            CustomViewCell(customView: UIImageView(image: #imageLiteral(resourceName: "randomImage")))
        ]
    }
}
