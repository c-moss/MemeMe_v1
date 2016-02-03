//
//  Meme.swift
//  MemeMe
//
//  Created by Campbell Moss on 14/01/16.
//  Copyright © 2016 Campbell Moss. All rights reserved.
//

import Foundation
import UIKit

class Meme: NSObject, NSCoding {
    
    // MARK: Types
    
    struct PropertyKey {
        static let topTextKey = "topText"
        static let bottomTextKey = "bottomText"
        static let originalImageKey = "originalImage"
        static let memedImageKey = "memedImage"
    }
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("memes")
    
    var topText: String?
    var bottomText: String?
    var originalImage: UIImage?
    var memedImage: UIImage?
    
    init(topText: String?, bottomText: String?, originalImage: UIImage?, memedImage: UIImage?) {
        self.topText = topText
        self.bottomText = bottomText
        self.originalImage = originalImage
        self.memedImage = memedImage
        
        super.init()
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let topText = aDecoder.decodeObjectForKey(PropertyKey.topTextKey) as? String
        let bottomText = aDecoder.decodeObjectForKey(PropertyKey.bottomTextKey) as? String
        let originalImage = aDecoder.decodeObjectForKey(PropertyKey.originalImageKey) as? UIImage
        let memedImage = aDecoder.decodeObjectForKey(PropertyKey.memedImageKey) as? UIImage
        
        self.init(topText: topText, bottomText: bottomText, originalImage: originalImage, memedImage: memedImage)
    }
    
    // MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(topText, forKey: PropertyKey.topTextKey)
        aCoder.encodeObject(bottomText, forKey: PropertyKey.bottomTextKey)
        aCoder.encodeObject(originalImage, forKey: PropertyKey.originalImageKey)
        aCoder.encodeObject(memedImage, forKey: PropertyKey.memedImageKey)
    }
}
