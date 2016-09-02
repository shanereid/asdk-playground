//
//  SRFoodViewController.swift
//  ASDK-Eat-Banter
//
//  Created by Shane I Reid on 02/09/2016.
//  Copyright © 2016 Shane Reid. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class SRFoodViewController: ASViewController {
    var tableNode: ASTableNode {
        return self.node as! ASTableNode
    }
    
    init(food: Food) {
        let tableNode = ASTableNode(style: .Grouped)
        tableNode.backgroundColor = UIColor.blueColor()
        
        super.init(node: tableNode)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
