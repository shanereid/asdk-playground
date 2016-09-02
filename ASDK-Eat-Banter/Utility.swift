//
//  Utility.swift
//  ASDK-Eat-Banter
//
//  Created by Shane I Reid on 02/09/2016.
//  Copyright © 2016 Shane Reid. All rights reserved.
//

import UIKit

class Utility {
    class func attributedString(str: String, font: UIFont, color: UIColor) -> NSAttributedString {
        let attributes: [String:AnyObject] = [
            NSForegroundColorAttributeName:color,
            NSFontAttributeName:font
        ]
        return NSAttributedString(string: str, attributes: attributes)
    }
}
