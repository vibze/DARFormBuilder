//
//  PhoneInputWithActionButton.swift
//  DARFormBuilder
//
//  Created by Kamila Kusainova on 26.10.2018.
//

import UIKit
import ContactsUI

public class PhoneInputWithActionButton: PhoneInput, CNContactPickerDelegate {

    public var presentSelector: ((UIViewController) -> Void)? = nil
    let button = UIButton()

    public init(placeholder: String, icon: UIImage) {
        super.init(placeholder, isFloat: false)
        textField.placeholder = placeholder
        button.setImage(icon, for: .normal)
        
        textField.rightView = button
        textField.rightViewMode = .always
        button.addTarget(self, action: #selector(openContact), for: .touchUpInside)
    }
    
    @objc func openContact() {
        let contactPicker = CNContactPickerViewController()
        contactPicker.delegate = self
        contactPicker.displayedPropertyKeys = [CNContactPhoneNumbersKey]
        presentSelector?(contactPicker)
    }
    
    public func contactPicker(_ picker: CNContactPickerViewController, didSelect contactProperty: CNContactProperty) {
        contactProperty.contact.phoneNumbers.forEach { contact in
            if contactProperty.identifier == contact.identifier {
                let phoneNumber = stripped(contact.value.stringValue)
                text = phoneNumber
            }
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        textField.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        button.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func stripped(_ text: String) -> String {
        let normalCharacter = Set("1234567890")
        return text.filter {normalCharacter.contains($0) }
    }
}
