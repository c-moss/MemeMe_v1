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
        let viewWidth = view.frame.size.width
        let viewHeight = view.frame.size.height
        if viewWidth < viewHeight { //portrait
            dimension = (viewWidth - (2 * space)) / 3.0
        } else {    //landscape
            dimension = ((viewWidth - (2 * space)) / 5.0) - 2 //need to reduce dimension by 2, otherwise it overflows onto the next row for some reason
        }

        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
        flowLayout.invalidateLayout()
    }
    
    override func viewWillAppear(animated: Bool) {
        collectionView?.reloadData()
    }

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
        let detailController = storyboard!.instantiateViewControllerWithIdentifier("MemeDetailVC") as! MemeDetailViewController
        
        //Populate view controller with data from the selected item
        detailController.meme = memes[indexPath.row]
        
        //Present the view controller using navigation
        navigationController!.pushViewController(detailController, animated: true)
    }
}
