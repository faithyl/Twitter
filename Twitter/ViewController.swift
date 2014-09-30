//
//  ViewController.swift
//  Twitter
//
//  Created by Faith Cox on 9/27/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogin(sender: AnyObject) {
        /*
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuthToken!) -> Void in
            println("Got the request token")
            var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL)
            }) { (error: NSError!) -> Void in
                println("Failed to get request token")
        }
        */
        
        TwitterClient.sharedInstance.loginWithCompletion() {
            (user: User?, error: NSError?) in
            if user != nil {
                self.user = user
                //perform segue
                self.performSegueWithIdentifier("loginSegue", sender: self)
            } else {
                //handle login error
            }
        }
    }

}