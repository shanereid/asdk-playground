//
//  SRFoodFancyCellNode.swift
//  ASDK-Eat-Banter
//
//  Created by Shane I Reid on 02/09/2016.
//  Copyright © 2016 Shane Reid. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class SRFoodFancyCellNode: ASCellNode {
    let food: Food
    
    init(food: Food) {
        self.food = food
        
        super.init()
        
        self.backgroundColor = UIColor.whiteColor()
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let cellPadding = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20),
            seeDetailsNode = ASTextNode(),
            seeDetailsFont = UIFont(name: "AvenirNext-Regular", size: 17)!
        
        self.addSubnode(seeDetailsNode)
        
        seeDetailsNode.attributedText = Utility.attributedString("See Details Fam", font: seeDetailsFont, color: UIColor.blueColor())
        var children = [ASLayoutable]()
        
        for i in 0..<4 {
            if i == 0 {
                children.append(self.generateRandomBlock())
            } else {
                children.append(self.generateCarbBlock())
            }
        }
        
        let horizSpec = ASStackLayoutSpec(
                direction: .Horizontal,
                spacing: 10,
                justifyContent: .Center,
                alignItems: .Center,
                children: children
            ),
            vertSpec = ASStackLayoutSpec(
                direction: .Vertical,
                spacing: 10,
                justifyContent: .Center,
                alignItems: .Center,
                children: [horizSpec, seeDetailsNode]
            ),
            insetSpec = ASInsetLayoutSpec(insets: cellPadding, child: vertSpec)
        
        return insetSpec
    }
    
    private func generateRandomBlock() -> ASLayoutable {
        let textNode = ASTextNode(),
            squareNode = ASDisplayNode(),
            font = UIFont(name: "AvenirNext-Regular", size: 12)!
        
        self.addSubnode(textNode)
        self.addSubnode(squareNode)
        
        textNode.attributedText = Utility.attributedString("Calories, Bruh", font: font, color: UIColor.blackColor())
        
        squareNode.backgroundColor = UIColor.grayColor()
        squareNode.preferredFrameSize = CGSize(width: 90, height: 90)
        
        let layoutSpec = ASStackLayoutSpec(
            direction: .Vertical,
            spacing: 5,
            justifyContent: .Center,
            alignItems: .Center,
            children: [textNode, squareNode]
        )
        
        return layoutSpec
    }
    
    private func generateCarbBlock() -> ASLayoutable {
        let textNode = ASTextNode(),
            squareNode = ASDisplayNode(),
            font = UIFont(name: "AvenirNext-Regular", size: 14)!
        
        self.addSubnode(textNode)
        self.addSubnode(squareNode)
        
        textNode.attributedText = Utility.attributedString("Carbs, Bruh", font: font, color: UIColor.blackColor())
        
        squareNode.backgroundColor = UIColor.redColor()
        squareNode.preferredFrameSize = CGSize(width: 60, height: 60)
        
        let layoutSpec = ASStackLayoutSpec(
            direction: .Vertical,
            spacing: 5,
            justifyContent: .Center,
            alignItems: .Center,
            children: [squareNode, textNode]
        )
        
        return layoutSpec
    }
}
