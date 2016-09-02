//
//  SRFoodCaloryCellNode.swift
//  ASDK-Eat-Banter
//
//  Created by Shane I Reid on 02/09/2016.
//  Copyright © 2016 Shane Reid. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class SRFoodCaloryCellNode: ASCellNode {
    let food: Food
    
    let caloryLabel = ASTextNode()
    let recommendedLabel = ASTextNode()
    let differenceLabel = ASTextNode()
    
    init(food: Food) {
        self.food = food
        
        super.init()
        
        self.backgroundColor = UIColor.whiteColor()
        
        self.addSubnode(self.caloryLabel)
        self.addSubnode(self.recommendedLabel)
        self.addSubnode(self.differenceLabel)
        
        self.configureChildren()
    }
    
    private func configureChildren() {
        let countFont = UIFont(name: "AvenirNext-Medium", size: 17)!,
            recommendationFont = UIFont(name: "AvenirNext-Regular", size: 12)!,
            differenceFont = UIFont(name: "AvenirNext-Regular", size: 12)!,
            countStr = "\(self.food.calories) kCal",
            recommendationStr = "Recommended: 433 - 579 kCal", // Where does this come from?
            differenceInt = 433 - self.food.calories,
            differenceStr = "\(abs(differenceInt)) kCal \(differenceInt < 0 ? "Over" : "Under")"
        
        self.caloryLabel.attributedText = Utility.attributedString(countStr, font: countFont, color: UIColor.blackColor())
        self.recommendedLabel.attributedText = Utility.attributedString(recommendationStr, font: recommendationFont, color: UIColor.blackColor())
        self.differenceLabel.attributedText = Utility.attributedString(differenceStr, font: differenceFont, color: UIColor.blackColor())
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let cellPadding = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20),
            spacer = ASLayoutSpec()
        spacer.flexGrow = true // This makes it a spacer
        
        print(constrainedSize)
        
        let horizStackLayout = ASStackLayoutSpec(
                direction: .Horizontal,
                spacing: 0,
                justifyContent: .Center,
                alignItems: .BaselineLast,
                children: [self.recommendedLabel, spacer, self.differenceLabel]
            ),
            vertStackLayout = ASStackLayoutSpec(
                direction: .Vertical,
                spacing: 10,
                justifyContent: .Start,
                alignItems: .Stretch,
                children: [self.caloryLabel, horizStackLayout]
            ),
            insetLayout = ASInsetLayoutSpec(insets: cellPadding, child: vertStackLayout)
        
        return insetLayout
    }
}
