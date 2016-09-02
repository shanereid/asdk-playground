//
//  UINavigationBar+Custom.swift
//  ASDK-Eat-Banter
//
//  Created by Shane I Reid on 02/09/2016.
//  Copyright © 2016 Shane Reid. All rights reserved.
//

import Foundation
import UIKit

// Try to stay away from force unwraps, I'm just being cheeky
let defaultFont: UIFont = UIFont(name: "AvenirNext-Medium", size: 20)!

extension UINavigationBar {
    func setBackgroundColour(colour: UIColor?) {
        if let colour = colour {
            self.translucent = false
            self.shadowImage = nil
            self.backgroundColor = colour
            self.setBackgroundImage(nil, forBarMetrics: .Default)
        } else {
            self.translucent = true
            self.shadowImage = UIImage()
            self.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        }
        
        self.titleTextAttributes = [
            NSFontAttributeName:defaultFont,
            NSForegroundColorAttributeName:UIColor.whiteColor()
        ]
        
        self.tintColor = UIColor.whiteColor()
    }
}