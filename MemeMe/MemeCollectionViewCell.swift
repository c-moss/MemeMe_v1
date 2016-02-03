//
//  MemeCollectionViewCell.swift
//  MemeMe
//
//  Created by Campbell Moss on 24/01/16.
//  Copyright © 2016 Campbell Moss. All rights reserved.
//

import UIKit

class MemeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var topCellLabel: UILabel!
    @IBOutlet weak var bottomCellLabel: UILabel!
    
    func setText(topText: String, bottomText: String) {
        topCellLabel.text = topText
        bottomCellLabel.text = bottomText
    }
}
