//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Faith Cox on 9/30/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tweets: [Tweet]?
    var user: User?
    var refreshControl: UIRefreshControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 85
        //self.navigationController?.navigationBar.barTintColor = UIColor.blueColor()
        
        
        // Do any additional setup after loading the view.
        TwitterClient.sharedInstance.homeTimeLineWithParams(nil, completion: { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        })
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweets?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("TweetCell") as TweetCell
        var tweet = self.tweets?[indexPath.row]
        cell.tweet = tweet
        return cell
    }
    
    func refresh(refreshControl: UIRefreshControl) {
        TwitterClient.sharedInstance.homeTimeLineWithParams(nil, completion:{ (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        })
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "segueTweetDetail") {
            var cell = sender as TweetCell
            var detailViewController = segue.destinationViewController as TweetDetailViewController
            detailViewController.tweet = cell.tweet
        } else if (segue.identifier == "newtweetSegue") {
            var newViewController = segue.destinationViewController as NewTweetViewController
        }
    }
}
