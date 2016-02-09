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
    
    //Array of memes. Stored here so that it is available to all controllers in the app
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
    func saveMemes(){
        // Saving memes to disk can take a while, so dispatch it to another thread
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            NSKeyedArchiver.archiveRootObject(self.memes, toFile: Meme.ArchiveURL.path!)
        }
    }
}

