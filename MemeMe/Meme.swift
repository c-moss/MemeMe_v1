//
//  Meme.swift
//  MemeMe
//
//  Created by Campbell Moss on 14/01/16.
//  Copyright © 2016 Campbell Moss. All rights reserved.
//

import Foundation
import UIKit

class Meme {
    var topText: String?
    var bottomText: String?
    var originalImage: UIImage?
    var memedImage: UIImage?
    
    init(topText: String?, bottomText: String?, originalImage: UIImage, memedImage: UIImage) {
        self.topText = topText
        self.bottomText = bottomText
        self.originalImage = originalImage
        self.memedImage = memedImage
    }
}
