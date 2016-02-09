//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Campbell Moss on 24/01/16.
//  Copyright © 2016 Campbell Moss. All rights reserved.
//

import UIKit

class SentMemesCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupFlowLayout()
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        setupFlowLayout()
    }
    
    func setupFlowLayout() {
        let space: CGFloat = 3.0
        var dimension: CGFloat
        let viewWidth = self.view.frame.size.width
        let viewHeight = self.view.frame.size.height
        if viewWidth < viewHeight { //portrait
            dimension = (viewWidth - (2 * space)) / 3.0
        } else {    //landscape
            dimension = ((viewWidth - (2 * space)) / 5.0) - 2
        }

        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
        flowLayout.invalidateLayout()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.collectionView?.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SentMemesCollectionViewCell", forIndexPath: indexPath) as! SentMemesCollectionViewCell
        let meme = memes[indexPath.item]
        cell.setText(meme.topText!, bottomText: meme.bottomText!)
        let imageView = UIImageView(image: meme.originalImage)
        cell.backgroundView = imageView
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //Grab the DetailVC from Storyboard
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailVC") as! MemeDetailViewController
        
        //Populate view controller with data from the selected item
        detailController.meme = self.memes[indexPath.row]
        
        //Present the view controller using navigation
        self.navigationController!.pushViewController(detailController, animated: true)
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
