//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by Campbell Moss on 24/01/16.
//  Copyright © 2016 Campbell Moss. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableViewController {
    
    // Access the memes array stored in the app delegate
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    override func viewWillAppear(animated: Bool) {
        // Reload the data to load any new memes
        tableView.reloadData()
        
        // If there aren't any memes yet, automatically show the Create Meme screen
        if memes.count == 0 {
            performSegueWithIdentifier("CreateMeme", sender: self)
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Retrieve meme from array and configure table view cell
        let cell:SentMemesTableViewCell = tableView.dequeueReusableCellWithIdentifier("SentMemesTableViewCell") as! SentMemesTableViewCell
        let meme = memes[indexPath.item]
        cell.memeTextLabel!.text = "\(meme.topText!) \(meme.bottomText!)"
        cell.memeThumbnailImage!.image = meme.originalImage
        cell.topCellText!.text = meme.topText
        cell.bottomCellText!.text = meme.bottomText
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //Grab the DetailVC from Storyboard
        let detailController = storyboard!.instantiateViewControllerWithIdentifier("MemeDetailVC") as! MemeDetailViewController
        
        //Populate view controller with data from the selected item
        detailController.meme = memes[indexPath.row]
        
        //Present the view controller using navigation
        navigationController!.pushViewController(detailController, animated: true)
    }
}
