//
//  DetailViewController.swift
//  Photos
//
//  Created by Franklin Rice on 11/17/15.
//  Copyright © 2015 iOS DeCal. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var heartImgLabel: UILabel!
    var photo: Photo!
    
    @IBAction func clickLike(sender: UIButton) {
        if (photo!.liked == true) {
            heartImgLabel.text = "💔"
            likes.text = "\(photo.likes) likes"
            photo.liked = false
        } else {
            heartImgLabel.text = "💗"
            likes.text = "\(photo.likes + 1) likes"
            photo.liked = true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let curr = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: photo!.url)!) {
            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if error == nil {
                self.image.image = UIImage(data: data!)
                self.image.frame = CGRectMake(0,0,UIScreen.mainScreen().bounds.size.width - 10, UIScreen.mainScreen().bounds.size.width - 10)
            }
        }
        curr.resume()
        username.text = self.photo!.username
        timeStamp.text = self.photo!.timeStamp
        likes.text = "\(self.photo!.likes) likes"
        if (photo!.liked == false) {
            heartImgLabel.text = "💔"
        } else {
            heartImgLabel.text = "💗"
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
