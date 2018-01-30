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

    public weak var scrollDelegate: FormControllerScrollDelegate?
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
            for row in rows {
                guard let row = row as? Row else { continue }
                for view in row.views {
                    if view.canBecomeFirstResponder {
                        responderViews.append(view)
                    }
                    
                    if let view = view as? CanMountTextInputAccessoryView {
                        view.mountTextInputAccessoryView(textInputAccessoryView)
                        textInputAccessoryView.frame = CGRect(x: 0, y: 0, width: 10, height: 44)
                    }
                }
            }
        }
    }
    
    public var responderViews: [UIView] = []
    
    public var hiddenRows: [IndexPath] = [] {
        didSet {
            tableView.beginUpdates()
            tableView.reloadData()
            tableView.endUpdates()
        }
    }
    
    public init() {
        super.init(style: .plain)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 70
        tableView.keyboardDismissMode = .interactive
        tableView.separatorStyle = .none
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if hiddenRows.contains(indexPath) {
            return 0
        }
        
        if let row = rows[indexPath.row] as? Row {
            return row.height
        }
        
        return 60
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = rows[indexPath.row]
        if let row = row as? Row {
            row.delegate = self
        }
        
        return row
    }
    
    public override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollDelegate?.scrollViewDidScroll(scrollView)
    }
    
    private let textInputAccessoryView = TextInputAccessoryView()
}

extension FormController: RowDelegate {
    func row(_ row: Row, didChangeHeight height: CGFloat) {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}

