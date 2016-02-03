//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Campbell Moss on 3/02/16.
//  Copyright © 2016 Campbell Moss. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    var meme: Meme!

    @IBOutlet weak var memeDetailImage: UIImageView!
    
    override func viewWillAppear(animated: Bool) {
        memeDetailImage.image = meme.memedImage
    }
    
}