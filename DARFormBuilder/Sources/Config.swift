//
//  Config.swift
//  DARFormBuilder
//
//  Created by Apple on 1/11/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit


public struct Config {
    public var primaryTextColor = UIColor.black
    public var labelTextColor = UIColor.lightGray
    public var separatorColor = UIColor.gray.withAlphaComponent(0.25)
    public var cellPadding = UIEdgeInsets(top: 12, left: 17, bottom: 12, right: 15)
    public var fontSize: CGFloat = 18
}


var config = Config()
