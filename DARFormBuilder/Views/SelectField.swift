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
        public let text: String
        public let value: String
        
        public init(text: String, value: String) {
            self.text = text
            self.value = value
        }
    }
    
    public var presentSelector: ((UIViewController) -> Void)? = nil
    public var dismissSelector: ((UIViewController) -> Void)? = nil
    public var onChange: ((Option) -> Void)? = nil
    
    public var options: [Option] = []
    public var button = UITableViewCell()
    public var selectedIndex = 0 {
        didSet {
            guard options.count > selectedIndex else { return }
            field.text = options[selectedIndex].text
            onChange?(options[selectedIndex])
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
        let selectController = SelectViewController(options: options, selectedIndex: selectedIndex)
        selectController.title = label.text
        selectController.delegate = self
        presentSelector?(selectController)
    }
    
    func selectViewController(_ controller: SelectViewController, didSelect option: SelectField.Option) {
        if let index = options.index(where: { $0.value == option.value }) {
            selectedIndex = index
            onChange?(options[selectedIndex])
        }
        dismissSelector?(controller)
    }
}


public class SelectViewController: UITableViewController {
    
    weak var delegate: SelectViewControllerDelegate?
    var selectedIndex: Int = 0
    let options: [SelectField.Option]
    
    public init(options: [SelectField.Option], selectedIndex: Int = 0) {
        self.options = options
        self.selectedIndex = selectedIndex
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
        cell.accessoryType = indexPath.row == selectedIndex ? .checkmark : .none
        
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
