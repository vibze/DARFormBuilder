//
//  CanBeValidated.swift
//  DARFormBuilder
//
//  Created by Apple on 2/20/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit


public protocol CanBeValidated: class {
    var errors: [String] { get }
    func showError()
    func hideError()
}
