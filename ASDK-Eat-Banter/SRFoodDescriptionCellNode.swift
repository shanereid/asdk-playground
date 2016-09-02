//
//  SRFoodDescriptionCellNode.swift
//  ASDK-Eat-Banter
//
//  Created by Shane I Reid on 02/09/2016.
//  Copyright © 2016 Shane Reid. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class SRFoodDescriptionCellNode: ASCellNode {
    let food: Food
    
    let vendorLabel = ASTextNode()
    let descriptionLabel = ASTextNode()
    
    init(food: Food) {
        self.food = food
        
        super.init()
        
        self.backgroundColor = UIColor.whiteColor()
        
        self.addSubnode(self.vendorLabel)
        self.addSubnode(self.descriptionLabel)
        
        self.configureChildren()
    }
    
    private func configureChildren() {
        let vendorFont = UIFont(name: "AvenirNext-Regular", size: 17)!,
            descriptionFont = UIFont(name: "AvenirNext-Regular", size: 14)!,
            vendorStr = "at \(self.food.vendor)"
        
        
        self.vendorLabel.attributedText = Utility.attributedString(vendorStr, font: vendorFont, color: UIColor.blackColor())
        self.descriptionLabel.attributedText = Utility.attributedString(self.food.description, font: descriptionFont, color: UIColor.blackColor())
    }
    
    private func attributedString(font: UIFont, string: String) -> NSAttributedString {
        let attributes: [String:AnyObject] = [
            NSForegroundColorAttributeName:UIColor.blackColor(),
            NSFontAttributeName:font
        ]
        return NSAttributedString(string: string, attributes: attributes)
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let cellPadding = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20),
            stackLayout = ASStackLayoutSpec(
                direction: .Vertical,
                spacing: 10,
                justifyContent: .Start,
                alignItems: .Start,
                children: [self.vendorLabel,self.descriptionLabel]
            ),
            insetLayout = ASInsetLayoutSpec(insets: cellPadding, child: stackLayout)
        
        return insetLayout
    }
}
