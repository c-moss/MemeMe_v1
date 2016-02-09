//
//  AppDelegate.swift
//  MemeMe
//
//  Created by Campbell Moss on 10/01/16.
//  Copyright © 2016 Campbell Moss. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    //Array of memes
    var memes: [Meme] = [Meme]()
    
    func application(application: UIApplication, willFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        //load stored memes when the application starts
        if let savedMemes = loadMemes() {
            memes = savedMemes
        }
        return true
    }
    
    // MARK: NSCoding
    
    /**
     Load memes from filesystem
     - returns: An array of Meme objects
     */
    func loadMemes() -> [Meme]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Meme.ArchiveURL.path!) as? [Meme]
    }
    
    /**
     Save memes to filesystem
     */
    func saveMemes() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(memes, toFile: Meme.ArchiveURL.path!)
        
        if !isSuccessfulSave {
            print("Failed to save memes")
        }
    }
}

