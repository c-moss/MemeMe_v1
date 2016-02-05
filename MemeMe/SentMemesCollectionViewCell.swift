//
//  SentMemesCollectionViewCell.swift
//  MemeMe
//
//  Created by Campbell Moss on 24/01/16.
//  Copyright © 2016 Campbell Moss. All rights reserved.
//

import UIKit

class SentMemesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var topCellText: UITextField!
    @IBOutlet weak var bottomCellText: UITextField!
    
    func setText(topText: String, bottomText: String) {
        // Set some text attributes
        var textAttributes = [String: AnyObject]()
        textAttributes[NSStrokeColorAttributeName] = UIColor.blackColor()
        textAttributes[NSForegroundColorAttributeName] = UIColor.whiteColor()
        textAttributes[NSFontAttributeName] = UIFont(name: "HelveticaNeue-CondensedBlack", size: 12)!
        textAttributes[NSStrokeWidthAttributeName] = -3.0   //negative value means we see the foreground color
        
        // Retrieve the existing default paragraph style from the top text field and use it in our new textAttributes, because otherwise it gets cleared and we lose center alignment
        let defaultParagraphStyle = topCellText.defaultTextAttributes[NSParagraphStyleAttributeName]
        textAttributes[NSParagraphStyleAttributeName] = defaultParagraphStyle
        
        topCellText.defaultTextAttributes = textAttributes
        bottomCellText.defaultTextAttributes = textAttributes
        
        topCellText.text = topText
        bottomCellText.text = bottomText
    }
}
