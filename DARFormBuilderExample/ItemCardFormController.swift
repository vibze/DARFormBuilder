//
//  ItemCardFormController.swift
//  DARFormBuilder
//
//  Created by Apple on 2/21/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit


class ItemCardFormController: UIViewController {
    
    let formController = FormTableViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(formController.tableView)
        formController.automaticallyAdjustsScrollViewInsets = false
        formController.tableView.frame = view.bounds
        
        let headingLabel = HeadingLabel(title: "Hamilton Intramatic 68", description: "Sure to delight Hamilton aficionados and collectors alike, the Intra-Matic 68 Auto Chrono emulates that of its illustrious inspiration with vintage-feel pushers placed on each side of the crown and the same solid stainless steel case back. This overall retro character and sense of heritage is further accentuated by a domed-shape dial and curved hands.")
        
        let priceField = KeyValueField("Price", value: "$2195")
        priceField.isEnabled = false
        
        let colorField = SelectField("Color", value: "black", options: [
            SelectField.Option(text: "Black", value: "black"),
            SelectField.Option(text: "White", value: "white")
        ])
        colorField.presentSelector = { [weak self] (vc) in
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        colorField.dismissSelector = { [weak self] (vc) in self?.navigationController?.popToViewController(self!, animated: true)
        }
        
        let amountField = KeyNumDialField("Amount", value: 1, range: 1..<5)
        
        formController.rows = [
            Row(headingLabel),
            Row(priceField),
            Row(colorField),
            Divider(),
            Row(amountField)
        ]
        
        let iv = UIImageView(image: #imageLiteral(resourceName: "watch"))
        iv.contentMode = .scaleAspectFit
        formController.tableView.tableHeaderView = iv
        formController.tableView.tableHeaderView?.frame = CGRect(x: 0, y: 0, width: 1, height: 300)
    }
}
