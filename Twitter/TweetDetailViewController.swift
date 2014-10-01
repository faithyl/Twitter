//
//  TweetDetailViewController.swift
//  Twitter
//
//  Created by Faith Cox on 9/30/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
    var tweet: Tweet?

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        profileImage.setImageWithURL(NSURL(string: tweet!.user!.profileImageUrl!))
        userLabel.text = tweet!.user!.name
        screennameLabel.text = "@\(tweet!.user!.screenname!)"
        tweetLabel.text = tweet?.text
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd, h:mm a"
        timeLabel.text = dateFormatter.stringFromDate(tweet!.createdAt!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
