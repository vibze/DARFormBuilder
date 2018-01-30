//
//  TextField.swift
//  DARFormBuilder
//
//  Created by Apple on 1/26/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit


class TextField: UITextView, UITextViewDelegate, CanAskParentToChangeHeight, CanMountTextInputAccessoryView {
    
    public weak var heightChangeDelegate: CanBeAskedToChangeHeight?
    public var onTextChange: ((String) -> Void)?
    
    public var maxLength: Int = 0 {
        didSet {
            updateCountLabel()
        }
    }
    
    public override var text: String? {
        didSet {
            textViewDidChange(self)
        }
    }
    
    private let countLabel = UILabel()
    private let placeholderLabel = UILabel()
    private var currentTextLength: Int {
        return text?.count ?? 0
    }
    
    public init(_ placeholder: String = "", maxLength: Int = 0) {
        super.init(frame: CGRect.zero, textContainer: nil)
        
        font = UIFont.preferredFont(forTextStyle: .body)
        textContainerInset = UIEdgeInsets.zero
        textContainer.lineFragmentPadding = 0
        
        placeholderLabel.text = placeholder
        self.maxLength = maxLength
        
        addSubview(countLabel)
        addSubview(placeholderLabel)
        
        countLabel.textColor = config.labelTextColor
        countLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        updateCountLabel()
        
        placeholderLabel.textColor = config.labelTextColor
        placeholderLabel.font = font

        isScrollEnabled = false
        bounces = false
        clipsToBounds = false
        delegate = self
        
        textViewDidChange(self)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        countLabel.frame.origin = CGPoint(x: bounds.width - countLabel.frame.width, y: bounds.height - countLabel.frame.height)
        
        textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: countLabel.frame.width + 5)
        textViewDidChange(self)
        updateHeight(for: text!)
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (self.text! as NSString).replacingCharacters(in: range as NSRange, with: text)
        if maxLength > 0 && newText.count > maxLength {
            return false
        }
        
        updateHeight(for: newText)
        
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        updateCountLabel()
        updatePlaceholder()
        onTextChange?(text!)
    }
    
    func mountTextInputAccessoryView(_ view: TextInputAccessoryView) {
        inputAccessoryView = view
    }
    
    private func updateHeight(for text: String) {
        let size = text.boundingRect(
            with: CGSize(width: textContainer.size.width - textContainer.lineFragmentPadding, height: .infinity),
            options: .usesLineFragmentOrigin,
            attributes: [NSFontAttributeName: font!],
            context: nil
        )
        let height = size.height + textContainerInset.top + textContainerInset.bottom + 28
        heightChangeDelegate?.changeHeight(to: height)
    }
    
    private func updateCountLabel() {
        countLabel.text = maxLength > 0 ? "\(currentTextLength)/\(maxLength)" : ""
        countLabel.sizeToFit()
    }
    
    private func updatePlaceholder() {
        currentTextLength > 0 ? floatLabel() : groundLabel()
    }
    
    private func floatLabel() {
        placeholderLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        UIView.animate(withDuration: 0.1) {
            self.placeholderLabel.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            self.placeholderLabel.sizeToFit()
            self.placeholderLabel.frame.origin = CGPoint(x: 0, y: -12)
        }
    }
    
    private func groundLabel() {
        placeholderLabel.font = UIFont.preferredFont(forTextStyle: .body)
        UIView.animate(withDuration: 0.1) {
            self.placeholderLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.placeholderLabel.frame = self.bounds
        }
    }
}


protocol CanBeAskedToChangeHeight: class {
    func changeHeight(to height: CGFloat)
}


protocol CanAskParentToChangeHeight: class {
    weak var heightChangeDelegate: CanBeAskedToChangeHeight? { get set }
}
