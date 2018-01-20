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

    public var cells: [BaseCell] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    public init() {
        super.init(style: .plain)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.keyboardDismissMode = .interactive
        tableView.separatorStyle = .none
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cells[indexPath.row]
        cell.configureCell()
        cell.delegate = self

        return cell
    }
    
    public override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollDelegate?.scrollViewDidScroll(scrollView)
    }
}

extension FormController: FormBuilderCellDelegate {
    func formBuilderCellDidUpdateHeight() {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func formBuilderCellNextFocusableCell(_ cell: BaseCell) -> BaseCell? {
        guard let index = cells.index(of: cell) else { return nil }
        for i in index...cells.count-1 {
            guard i != index else { continue }
            let cell = cells[i]
            if cell.canBecomeFocused {
                return cell
            }
        }
        
        return nil
    }
    
    func formBuilderCellPrevFocusableCell(_ cell: BaseCell) -> BaseCell? {
        guard let index = cells.index(of: cell) else { return nil }
        for i in (0...index).reversed() {
            guard i != index else { continue }
            let cell = cells[i]
            if cell.canBecomeFocused {
                return cell
            }
        }
        
        return nil
    }
    
    func formBuilderCellScrollToCell(_ cell: BaseCell) {
        guard let index = cells.index(of: cell) else { return }
        tableView.scrollToRow(at: IndexPath(row: index, section: 0), at: .bottom, animated: true)
    }
    
    var formBuilderCellConfig: Config {
        return config
    }
}
