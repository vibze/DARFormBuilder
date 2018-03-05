//
//  TextInputAccessoryView.swift
//  DARFormBuilder
//
//  Created by Apple on 1/12/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit


public class TextInputAccessoryView: UIView {
    
    public weak var delegate: TextInputAccessoryViewDelegate?
    
    let toolbar = UIToolbar()
    weak var holder: UIView?
    var prevButton: UIBarButtonItem!
    var nextButton: UIBarButtonItem!
    var doneButton: UIBarButtonItem!
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 10, height: 44))
        
        prevButton = UIBarButtonItem(title: "Пред", style: .plain, target: self, action: #selector(didTapPrevButton))
        nextButton = UIBarButtonItem(title: "След", style: .plain, target: self, action: #selector(didTapNextButton))
        doneButton = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(didTapDoneButton))
        
        addSubview(toolbar)
        toolbar.items = [prevButton, nextButton, UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), doneButton]
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        toolbar.frame = bounds
    }
    
    func didTapPrevButton(_ sender: UIBarButtonItem) {
        guard let sender = holder else { return }
        delegate?.textInputAccessoryViewPrev(sender: sender)
    }
    
    func didTapNextButton(_ sender: UIBarButtonItem) {
        guard let sender = holder else { return }
        delegate?.textInputAccessoryViewNext(sender: sender)
    }
    
    func didTapDoneButton(_ sender: UIBarButtonItem) {
        guard let sender = holder else { return }
        delegate?.textInputAccessoryViewDone(sender: sender)
    }
}


public protocol TextInputAccessoryViewDelegate: class {
    func textInputAccessoryViewPrev(sender: UIView)
    func textInputAccessoryViewNext(sender: UIView)
    func textInputAccessoryViewDone(sender: UIView)
}

