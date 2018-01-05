//
//  FormControllerDelegate.swift
//  DARFormBuilder
//
//  Created by Apple on 1/5/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit


public protocol FormControllerDelegate: class {
    func formController(_ formController: FormController, didChangeIntValueForKey key: String, value: Int)
    func formController(_ formController: FormController, didChangeStringValueForKey key: String, value: String)
    func formController(_ formController: FormController, didChangeBoolValueForKey key: String, value: Bool)
    func formController(_ formController: FormController, didChangeDateValueForKey key: String, value: Date)
}

extension FormControllerDelegate {
    func formController(_ formController: FormController, didChangeIntValueForKey key: String, value: Int) {}
    func formController(_ formController: FormController, didChangeStringValueForKey key: String, value: String) {}
    func formController(_ formController: FormController, didChangeBoolValueForKey key: String, value: Bool) {}
    func formController(_ formController: FormController, didChangeDateValueForKey key: String, value: Date) {}
}
