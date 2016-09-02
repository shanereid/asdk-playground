//
//  SRFoodViewController.swift
//  ASDK-Eat-Banter
//
//  Created by Shane I Reid on 02/09/2016.
//  Copyright © 2016 Shane Reid. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class SRFoodViewController: ASViewController, ASTableDelegate, ASTableDataSource {
    let food: Food
    var tableNode: ASTableNode {
        return self.node as! ASTableNode
    }
    
    init(food: Food) {
        self.food = food
        
        let tableNode = ASTableNode(style: .Grouped)
        
        super.init(node: tableNode)
        
        self.navigationItem.title = "I am a food item"
        
        self.tableNode.delegate = self
        self.tableNode.dataSource = self
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.setBackgroundColour(nil)
    }
    
    func tableView(tableView: ASTableView, nodeBlockForRowAtIndexPath indexPath: NSIndexPath) -> ASCellNodeBlock {
        let cellNodeBlock = { () -> ASCellNode in
            switch (indexPath.section, indexPath.row) {
            case (0, 0):
                return SRFoodDescriptionCellNode(food: self.food)
            case (0, 1):
                return SRFoodCaloryCellNode(food: self.food)
            case (1, 0):
                return SRFoodFancyCellNode(food: self.food)
            default:
                return ASCellNode()
            }
        }
        
        return cellNodeBlock
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
