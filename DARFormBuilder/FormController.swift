//
//  FormController.swift
//  DARFormBuilder
//
//  Created by Apple on 1/5/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit


public protocol FormControllerScrollDelegate: class {
    func scrollViewDidScroll(_ scrollView: UIScrollView)
}

/**
 Табличка, с помощью которой можно нарисовать форму!
 
 1. Для конфигурации самой формы нужно сформировать массив items.
 2. Для установки значений в форму нужно дать dataSource (делегат)
 3. Для реакции на изменения значений delegate.
 4. Реакция на скроллинг - scrollDelegate
 Просто передаете в параметр items список айтемов, каждый из которых представляет какой-то
 элемент формы.
 */
public class FormController: UITableViewController {
    
    public enum Item {
        case title(text: String)
        case description(text: String)
        case staticValue(label: String, value: String)
        case numDialInput(label: String, key: String)
        case textInput(label: String, placeholder: String, keyboardType: UIKeyboardType, key: String)
        case dateInput(label: String, placeholder: String, key: String)
        case switchInput(label: String, key: String)
    }
    
    public weak var scrollDelegate: FormControllerScrollDelegate?
    public weak var dataSource: FormControllerDataSource?
    public weak var delegate: FormControllerDelegate?
    
    public var items: [Item] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    init() {
        super.init(style: .plain)
        
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.keyboardDismissMode = .interactive
        
        tableView.register(TitleCell.self, forCellReuseIdentifier: "title")
        tableView.register(DescriptionCell.self, forCellReuseIdentifier: "description")
        tableView.register(StaticValueCell.self, forCellReuseIdentifier: "labeledValue")
        tableView.register(NumDialInputCell.self, forCellReuseIdentifier: "labeledNumDial")
        tableView.register(TextInputCell.self, forCellReuseIdentifier: "textfield")
        tableView.register(DateInputCell.self, forCellReuseIdentifier: "dateField")
        tableView.register(SwitchInputCell.self,forCellReuseIdentifier: "labeledSwitch")
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        
        let cell: UITableViewCell = {
            switch item {
            case .title(let text): return configureTitleCell(indexPath: indexPath, text: text)
            case .description(let text): return configureDescriptionCell(indexPath: indexPath, text: text)
            case .staticValue(let label, let value): return configureStaticValueCell(indexPath: indexPath, label: label, value: value)
            case .numDialInput(let label, let key): return configureNumDialInputCell(indexPath: indexPath, label: label, key: key)
            case .textInput(let label, let placeholder, let keyboardType, let key): return configureTextInputCell(indexPath: indexPath, label: label, placeholder: placeholder, keyboardType: keyboardType, key: key)
            case .dateInput(let label, let placeholder, let key): return configureDateInputCell(indexPath: indexPath, label: label, placeholder: placeholder, key: key)
            case .switchInput(let label, let key): return configureSwitchInputCell(indexPath: indexPath, label: label, key: key)
            }
        }()
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    public override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollDelegate?.scrollViewDidScroll(scrollView)
    }
    
    private func configureTitleCell(indexPath: IndexPath, text: String) -> TitleCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "title", for: indexPath) as! TitleCell
        cell.titleText = text
        return cell
    }
    
    private func configureDescriptionCell(indexPath: IndexPath, text: String) -> DescriptionCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "description", for: indexPath) as! DescriptionCell
        cell.descText = text
        return cell
    }
    
    private func configureStaticValueCell(indexPath: IndexPath, label: String, value: String) -> StaticValueCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "labeledValue", for: indexPath) as! StaticValueCell
        cell.label = label
        cell.value = value
        return cell
    }
    
    private func configureNumDialInputCell(indexPath: IndexPath, label: String, key: String) -> NumDialInputCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "labeledNumDial", for: indexPath) as! NumDialInputCell
        cell.label = label
        cell.value = dataSource?.formController(self, intValueForKey: key) ?? 0
        cell.onValueChanged = { [weak self] value in
            self?.delegate?.formController(self!, didChangeIntValueForKey: key, value: value)
        }
        return cell
    }
    
    private func configureTextInputCell(indexPath: IndexPath, label: String, placeholder: String, keyboardType: UIKeyboardType, key: String) -> TextInputCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "textfield", for: indexPath) as! TextInputCell
        cell.placeholder = placeholder
        cell.textValue = dataSource?.formController(self, stringValueForKey: key) ?? ""
        cell.onTextChange = { [weak self] value in
            self?.delegate?.formController(self!, didChangeStringValueForKey: key, value: value)
        }
        return cell
    }
    
    private func configureDateInputCell(indexPath: IndexPath, label: String, placeholder: String, key: String) -> DateInputCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dateField", for: indexPath) as! DateInputCell
        cell.placeholder = placeholder
        cell.dateValue = dataSource?.formController(self, dateValueForKey: key) ?? Date()
        cell.onDateChange = { [weak self] value in
            self?.delegate?.formController(self!, didChangeDateValueForKey: key, value: value)
        }
        return cell
    }
    
    private func configureSwitchInputCell(indexPath: IndexPath, label: String, key: String) -> SwitchInputCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "labeledSwitch", for: indexPath) as! SwitchInputCell
        cell.label = label
        cell.value = dataSource?.formController(self, boolValueForKey: key) ?? false
        cell.onValueChanged = { [weak self] value in
            self?.delegate?.formController(self!, didChangeBoolValueForKey: key, value: value)
        }
        return cell
    }
}

