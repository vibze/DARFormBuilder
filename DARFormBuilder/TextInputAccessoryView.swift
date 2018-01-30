//
//  TextInputAccessoryView.swift
//  DARFormBuilder
//
//  Created by Apple on 1/12/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit


class TextInputAccessoryView: UIView {
    
    weak var delegate: TextInputAccessoryViewDelegate?
    
    let toolbar = UIToolbar()
    var prevButton: UIBarButtonItem!
    var nextButton: UIBarButtonItem!
    var doneButton: UIBarButtonItem!
    
    init() {
        super.init(frame: CGRect.zero)
        
        prevButton = UIBarButtonItem(title: "Пред", style: .plain, target: self, action: #selector(didTapPrevButton))
        nextButton = UIBarButtonItem(title: "След", style: .plain, target: self, action: #selector(didTapNextButton))
        doneButton = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(didTapDoneButton))
        
        addSubview(toolbar)
        toolbar.items = [prevButton, nextButton, UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), doneButton]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        toolbar.frame = bounds
    }
    
    func didTapPrevButton(_ sender: UIBarButtonItem) {
        delegate?.textInputAccessoryViewPrev()
    }
    
    func didTapNextButton(_ sender: UIBarButtonItem) {
        delegate?.textInputAccessoryViewNext()
    }
    
    func didTapDoneButton(_ sender: UIBarButtonItem) {
        delegate?.textInputAccessoryViewDone()
    }
}


protocol TextInputAccessoryViewDelegate: class {
    func textInputAccessoryViewPrev()
    func textInputAccessoryViewNext()
    func textInputAccessoryViewDone()
}

