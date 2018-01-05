//
//  FormControllerDataSource.swift
//  DARFormBuilder
//
//  Created by Apple on 1/5/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import Foundation


public protocol FormControllerDataSource: class {
    func formController(_ formController: FormController, intValueForKey key: String) -> Int?
    func formController(_ formController: FormController, stringValueForKey key: String) -> String?
    func formController(_ formController: FormController, boolValueForKey key: String) -> Bool?
    func formController(_ formController: FormController, dateValueForKey key: String) -> Date?
}


public extension FormControllerDataSource {
    func formController(_ formController: FormController, intValueForKey key: String) -> Int? {
        return 0
    }
    
    func formController(_ formController: FormController, stringValueForKey key: String) -> String? {
        return ""
    }
    
    func formController(_ formController: FormController, boolValueForKey key: String) -> Bool? {
        return false
    }
    
    func formController(_ formController: FormController, dateValueForKey key: String) -> Date? {
        return Date()
    }
}
