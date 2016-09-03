//
//  SRFoodFancyCellNode.swift
//  ASDK-Eat-Banter
//
//  Created by Shane I Reid on 02/09/2016.
//  Copyright © 2016 Shane Reid. All rights reserved.
//

import UIKit
import AsyncDisplayKit

// http://asyncdisplaykit.org/docs/layout-transition-api.html

class SRFoodFancyCellNode: ASCellNode {
    let food: Food,
        detailsNode = ASTextNode()
    
    var squareLayout: ASLayoutable? = nil
    var detailHidden = true {
            didSet {
                self.configureChildren()
                self.setNeedsLayout()
            }
        }
    
    init(food: Food) {
        self.food = food
        
        super.init()
        
        self.usesImplicitHierarchyManagement = true // This means you don't have to use self.addSubnode, ASDK will handle for you
        self.backgroundColor = UIColor.whiteColor()
        
        self.configureChildren()
    }
    
    override func didLoad() {
        self.detailsNode.addTarget(self, action: #selector(SRFoodFancyCellNode.detailsTapped), forControlEvents: .TouchUpInside)
    }
    
    private func configureChildren() {
        let detailFont = UIFont(name: "AvenirNext-Regular", size: 17)!,
            detailStr = detailHidden ? "See Details Fam" : "Hide Details Fam"
        
        self.detailsNode.attributedText = Utility.attributedString(detailStr, font: detailFont, color: UIColor.blueColor())
        self.detailsNode.alignSelf = .Center
    }
    
    private func generateSquareLayoutSpec() -> ASLayoutable {
        guard self.squareLayout == nil else { return self.squareLayout! }
        
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
        )
        // Save it so it doesn't flash when we reload!
        self.squareLayout = horizSpec
        
        return horizSpec
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let cellPadding = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20),
            horizSpec = self.generateSquareLayoutSpec()
        
        var verticalChildren: [ASLayoutable] = [
            horizSpec,
            self.detailsNode
        ]
        
        if !self.detailHidden {
            verticalChildren.append(self.generateCaloryDetailLine())
            verticalChildren.append(self.generateContentLine())
        }
        
        let vertSpec = ASStackLayoutSpec(
                direction: .Vertical,
                spacing: 10,
                justifyContent: .Center,
                alignItems: .Stretch,
                children: verticalChildren
            ),
            insetSpec = ASInsetLayoutSpec(insets: cellPadding, child: vertSpec)
        
        return insetSpec
    }
    
    private func generateContentLine() -> ASLayoutable {
        let imageNode1 = ASNetworkImageNode(),
            imageNode2 = ASNetworkImageNode(),
            spacer = ASLayoutSpec(),
            imageURL1 = NSURL(string: "https://static.grabble.com/misc/Summer-Street-Style-04.png")!,
            imageURL2 = NSURL(string: "https://static.grabble.com/misc/544349-2.jpg")!
        
        imageNode1.URL = imageURL1
        imageNode1.preferredFrameSize = CGSize(width: 112, height: 200)
        
        imageNode2.URL = imageURL2
        imageNode2.preferredFrameSize = CGSize(width: 112, height: 200)
        
        spacer.flexGrow = true
        
        return ASStackLayoutSpec(
            direction: .Horizontal,
            spacing: 0,
            justifyContent: .Center,
            alignItems: .Stretch,
            children: [imageNode1, spacer, imageNode2]
        )
    }
    
    private func generateCaloryDetailLine() -> ASLayoutable {
        let keyLabel = ASTextNode(),
            keyText = "Calories",
            valueText = "\(self.food.calories) kCals",
            valueLabel = ASTextNode(),
            font = UIFont(name: "AvenirNext-Regular", size: 17)!,
            spacer = ASLayoutSpec()
        spacer.flexGrow = true
        
        keyLabel.attributedText = Utility.attributedString(keyText, font: font, color: UIColor.blackColor())
        valueLabel.attributedText = Utility.attributedString(valueText, font: font, color: UIColor.blackColor())
        
        return ASStackLayoutSpec(
            direction: .Horizontal,
            spacing: 0,
            justifyContent: .Center,
            alignItems: .Stretch,
            children: [keyLabel, spacer, valueLabel]
        )
    }
    
    // https://static.grabble.com/misc/lasagna.jpg
    
    private func generateRandomBlock() -> ASLayoutable {
        let textNode = ASTextNode(),
            squareNode = ASNetworkImageNode(),
            imageURL = NSURL(string: "https://static.grabble.com/misc/lasagna.jpg")!,
            font = UIFont(name: "AvenirNext-Regular", size: 12)!
        
        textNode.attributedText = Utility.attributedString("Calories, Bruh", font: font, color: UIColor.blackColor())
        
        squareNode.URL = imageURL
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
            squareNode = ASNetworkImageNode(),
            imageURL = NSURL(string: "https://static.grabble.com/misc/lasagna.jpg")!,
            font = UIFont(name: "AvenirNext-Regular", size: 14)!
        
        textNode.attributedText = Utility.attributedString("Carbs, Bruh", font: font, color: UIColor.blackColor())
        
        squareNode.URL = imageURL
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
    
    func detailsTapped() {
        self.detailHidden = !self.detailHidden
    }
}
