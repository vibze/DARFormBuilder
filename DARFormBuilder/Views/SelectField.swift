//
//  SelectField.swift
//  DARFormBuilder
//
//  Created by Viktor Ten on 2/22/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit


/**
 Select field allows user to choose one from the list of provided options.
 Picker controller presentation is up to you. For that you have to provide
 presentSelector and dismissSelector callbacks which get presented view
 controller as the only parameter.
 
 Usage example:
 
 ```Swift
 let field = SelectField("Vegetables")
 
 field.options = [
    SelectField.Option(text: "Potato", value: 1),
    SelectField.Option(text: "Carrot", value: 2),
    SelectField.Option(text: "Cucumber", value: 3)
 ]
 
 field.presentSelector = { [weak self] viewController in
    self?.navigationController?.push(viewController: vc, animated: true)
 }
 field.onChange = { [weak self] option in
    ...
 }
 ```
 
 Select field also supports blurring and disabling options.
 Blurring means the option will be grayed out but will still be selectable.
 Disabled options will be grayed out and unselectable.
 
 Blurred and disabled options are set by `blurredOptionsValues` and `disabledOptionsValues`
 respectively. These sets contain values of the options that should be blurred/disabled.
 
 */
public class SelectField: KeyValueField, SelectViewControllerDelegate {

    public struct Option {
        public let text: String
        public let value: String
        
        public init(text: String, value: String) {
            self.text = text
            self.value = value
        }
    }
    
    public var blurredOptionValues: Set<String> = []
    public var disabledOptionValues: Set<String> = []
    
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
        selectController.blurredOptionValues = blurredOptionValues
        selectController.disabledOptionValues = disabledOptionValues
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
    
    var blurredOptionValues: Set<String> = []
    var disabledOptionValues: Set<String> = []
    
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
        cell.textLabel?.textColor = config.primaryTextColor
        
        if blurredOptionValues.contains(option.value) || disabledOptionValues.contains(option.value) {
            cell.textLabel?.textColor = config.labelTextColor
        }
        
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let option = options[indexPath.row]
        guard !disabledOptionValues.contains(option.value) else { return }
        delegate?.selectViewController(self, didSelect: option)
    }
}


protocol SelectViewControllerDelegate: class {
    func selectViewController(_ controller: SelectViewController, didSelect option: SelectField.Option)
}
