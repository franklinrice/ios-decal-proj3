//
//  PhotosCollectionViewController.swift
//  Photos
//
//  Created by Gene Yoo on 11/3/15.
//  Copyright © 2015 iOS DeCal. All rights reserved.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {
    var photos: [Photo]! = [Photo]()
    let width: CGFloat = UIScreen.mainScreen().bounds.size.width * 48 / 100
    let height: CGFloat = UIScreen.mainScreen().bounds.size.height * 33 / 100
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let api = InstagramAPI()
        api.loadPhotos(didLoadPhotos)
        // FILL ME IN
    }

    /* 
     * IMPLEMENT ANY COLLECTION VIEW DELEGATE METHODS YOU FIND NECESSARY
     * Examples include cellForItemAtIndexPath, numberOfSections, etc.
     */
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: width, height: height)
    }
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (photos != nil) {
            return photos.count
        }
        return 0
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = self.collectionView?.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! PhotoCell!
        cell.imageView = UIImageView(frame: CGRectMake(0,0,width,height))
        
        if (photos != nil) {
            loadImageForCell(photos[indexPath.row], imageView: cell.imageView)
            cell.addSubview(cell.imageView)
        }
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //segue to individual view
        performSegueWithIdentifier("toDetail", sender: indexPath)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "toDetail") {
            let path = sender as! NSIndexPath
            let dest = segue.destinationViewController as! DetailViewController
            dest.photo = photos[path.row]
            dest.image = UIImageView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.width))
        }
    }
    
    /* Creates a session from a photo's url to download data to instantiate a UIImage. 
       It then sets this as the imageView's image. */
    func loadImageForCell(photo: Photo, imageView: UIImageView) {
        let curr = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: photo.url)!) {
            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if error == nil {
                imageView.image = UIImage(data: data!)
            }
        }
        curr.resume()
    }
    
    /* Completion handler for API call. DO NOT CHANGE */
    func didLoadPhotos(photos: [Photo]) {
        self.photos = photos
        self.collectionView!.reloadData()
    }
    
}

