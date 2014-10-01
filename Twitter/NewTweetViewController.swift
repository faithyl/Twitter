//
//  NewTweetViewController.swift
//  Twitter
//
//  Created by Faith Cox on 10/1/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

import UIKit

protocol NewTweetViewControllerDelegate {
    func didComposeNewTweet (newTweetViewController: NewTweetViewController, tweet: Tweet)
}

class NewTweetViewController: UIViewController, UITextViewDelegate {
    
    var delegate: NewTweetViewController? = nil
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var tweetText: UITextView!
    
    var countdownLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        var navbar = navigationController?.navigationBar
        countdownLabel = UILabel(frame: CGRectMake(230, 16, 40, 30))
        //countdownLabel = UILabel(frame: CGRectMake(<#x: CGFloat#>, <#y: CGFloat#>, <#width: CGFloat#>, <#height: CGFloat#>)
        countdownLabel.font = UIFont(name: "Helvetica", size: 12)
        countdownLabel.text = "140"
        countdownLabel.textColor = UIColor.lightGrayColor()
        countdownLabel.sizeToFit()
        navbar?.addSubview(countdownLabel)
        
        tweetText.delegate = self
        tweetText.becomeFirstResponder()
        
        userLabel.text = User.currentUser!.name
        screennameLabel.text = "@\(User.currentUser!.screenname!)"
        var profileURL = User.currentUser!.profileImageUrl!
        profileImage.setImageWithURL(NSURL(string: profileURL))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewDidChange(textView: UITextView) {
        var n = 140 - countElements(textView.text)
        
        countdownLabel.text = "\(n)"
        
        if n < 10 {
            countdownLabel.textColor = UIColor.redColor()
        } else if n < 20 {
            countdownLabel.textColor = UIColor.orangeColor()
        } else {
            countdownLabel.textColor = UIColor.lightGrayColor()
        }
    }
    
    @IBAction func onCancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func onTweet(sender: AnyObject) {
        let client = TwitterClient.sharedInstance
        
        client.tweet(tweetText.text) {
            (error: NSError!) -> Void in
            
            if error != nil {
                UIAlertView(
                title: "Error",
                message: "Your tweet could not be sent. Please try again later",
                delegate: self,
                cancelButtonTitle: "Cancel").show()
            } else {
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        var newLen = countElements(textView.text) - range.length + countElements(text)
        
        if newLen <= 140 {
            return true
        }
        
        return false
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
