//
//  SelectField.swift
//  DARFormBuilder
//
//  Created by Apple on 2/22/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit


public class SelectField: KeyValueField, SelectViewControllerDelegate {

    public struct Option {
        let text: String
        let value: String
    }
    
    public var presentSelector: ((UIViewController) -> Void)? = nil
    public var dismissSelector: ((UIViewController) -> Void)? = nil
    
    public var options: [Option] = []
    public var button = UITableViewCell()
    public var selectedIndex = 0 {
        didSet {
            guard options.count > selectedIndex else { return }
            field.text = options[selectedIndex].text
        }
    }
    
    public init(_ key: String, value: String = "", options: [Option] = []) {
        super.init(key, value: value, isEnabled: false)
        self.options = options
        
        button.accessoryType = .disclosureIndicator
        let tgs = UITapGestureRecognizer(target: self, action: #selector(didTapField))
        
        field.rightView = button
        field.rightViewMode = .always
        addGestureRecognizer(tgs)
        
        if let index = options.index(where: { $0.value == value }) {
            selectedIndex = index
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        field.frame = CGRect(x: bounds.width/2, y: 0, width: bounds.width/2 + 8, height: bounds.height)
        button.frame = CGRect(x: 0, y: 0, width: 25, height: 0)
    }
    
    func didTapField(_ sender: UITapGestureRecognizer) {
        let selectController = SelectViewController(options: options)
        selectController.title = label.text
        selectController.delegate = self
        presentSelector?(selectController)
    }
    
    func selectViewController(_ controller: SelectViewController, didSelect option: SelectField.Option) {
        if let index = options.index(where: { $0.value == option.value }) {
            selectedIndex = index
        }
        dismissSelector?(controller)
    }
}


public class SelectViewController: UITableViewController {
    
    weak var delegate: SelectViewControllerDelegate?
    let options: [SelectField.Option]
    
    public init(options: [SelectField.Option]) {
        self.options = options
        super.init(style: .plain)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let option = options[indexPath.row]
        cell.textLabel?.text = option.text
        
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let option = options[indexPath.row]
        delegate?.selectViewController(self, didSelect: option)
    }
}


protocol SelectViewControllerDelegate: class {
    func selectViewController(_ controller: SelectViewController, didSelect option: SelectField.Option)
}
