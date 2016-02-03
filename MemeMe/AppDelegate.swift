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
    var memes: [Meme] = [Meme]()
    
     func application(application: UIApplication, willFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        if let savedMemes = loadMemes() {
            memes = savedMemes
        }
        return true
    }
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        return true
    }
    
    // MARK: NSCoding
    
    func loadMemes() -> [Meme]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Meme.ArchiveURL.path!) as? [Meme]
    }
    
    func saveMemes() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(memes, toFile: Meme.ArchiveURL.path!)
        
        if !isSuccessfulSave {
            print("Failed to save memes")
        }
    }
}

