//
//  FormTableViewController.swift
//  DARFormBuilder
//
//  Created by Apple on 1/5/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit


public protocol FormControllerScrollDelegate: class {
    func scrollViewDidScroll(_ scrollView: UIScrollView)
}

public protocol FormTableViewControllerDelegate: class {
    func formTableViewController(_ controller: FormTableViewController, presentViewController viewController: UIViewController)
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
open class FormTableViewController: UITableViewController, TextInputAccessoryViewDelegate {

    public weak var scrollDelegate: FormControllerScrollDelegate?
    public weak var delegate: FormTableViewControllerDelegate?
    
    public var config = Config()
    public var bottomInset: CGFloat = 0 {
        didSet {
            var inset = tableView.contentInset
            inset.bottom = bottomInset
            tableView.contentInset = inset
            tableView.scrollIndicatorInsets = inset
        }
    }

    public var rows: [UITableViewCell] = [] {
        didSet {
            tableView.reloadData()
            
            responderViews = []
            validatableFields = []
            
            for row in rows {
                guard let row = row as? Row else { continue }
                for view in row.views {
                    if view.canBecomeFirstResponder {
                        responderViews.append(view)
                    }
                    
                    if let view = view as? TextInputAccessoryViewHolder {
                        view.textInputAccessoryView.delegate = self
                    }
                    
                    if let field = view as? CanBeValidated {
                        validatableFields.append(field)
                    }
                }
            }
        }
    }
    
    public var responderViews: [UIView] = []
    public var validatableFields: [CanBeValidated] = []
    
    public var hiddenRows: [IndexPath] = [] {
        didSet {
            tableView.beginUpdates()
            tableView.reloadRows(at: hiddenRows, with: .automatic)
            tableView.endUpdates()
        }
    }
    
    public init() {
        super.init(style: .plain)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 70
        tableView.keyboardDismissMode = .interactive
        tableView.separatorStyle = .none
        
        textInputAccessoryView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(willShowKeyboard), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willHideKeyboard), name: Notification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadHeight), name: Notification.Name("cellDidUpdateHeight"), object: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if hiddenRows.contains(indexPath) {
            return 0
        }
        
        if let row = rows[indexPath.row] as? Row {
            return row.height
        }
        
        if let divider = rows[indexPath.row] as? Divider {
            return divider.height
        }
        
        return 70
    }
    
    func reloadHeight() {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return rows[indexPath.row]
    }
    
    open override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollDelegate?.scrollViewDidScroll(scrollView)
    }
    
    public func textInputAccessoryViewNext(sender: UIView) {
        guard
            let senderIndex = responderViews.index(of: sender),
            responderViews.count > senderIndex + 1 else { return }
        responderViews[senderIndex + 1].becomeFirstResponder()
    }
    
    public func textInputAccessoryViewPrev(sender: UIView) {
        guard
            let senderIndex = responderViews.index(of: sender),
            senderIndex > 0 else { return }
        responderViews[senderIndex - 1].becomeFirstResponder()
    }
    
    public func textInputAccessoryViewDone(sender: UIView) {
        view.endEditing(true)
    }
    
    private let textInputAccessoryView = TextInputAccessoryView()
    
    func willShowKeyboard(notification: Notification) {
        guard
            let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        
        var inset = tableView.contentInset
        inset.bottom = keyboardHeight
        //tableView.contentInset = inset
        //tableView.scrollIndicatorInsets = inset
    }
    
    func willHideKeyboard(notification: Notification) {
        var inset = tableView.contentInset
        inset.bottom = 0
        //tableView.contentInset = inset
        //tableView.scrollIndicatorInsets = inset
    }
}
