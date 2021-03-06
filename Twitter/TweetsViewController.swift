//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Edison Lam on 2/18/17.
//  Copyright © 2017 Edison Lam. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var tweets: [Tweet]! = []
    var segueIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor.white
        
        print("Loading TweetsViewController")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 150
        
        // GET request to get home timeline
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            print("Got the home timeline")
            
            /*for tweet in tweets {
                print("\(tweet.text ?? "")")
            }*/
            
            self.tableView.reloadData()
            
        }, failure: { (error: Error) in
            print("Failed to get home timeline")
            print("error: \(error.localizedDescription)")
        })

        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets.count
        } else {
            return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        cell.tweet = tweets[indexPath.row]
        
        cell.profileImageBtn.tag = indexPath.row
        cell.profileImageBtn.addTarget(self, action: #selector(TweetsViewController.onProfileImgPressed(_:)), for: UIControlEvents.touchUpInside)
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.segueIndex = indexPath.row
        performSegue(withIdentifier: "segueToTweetDetailViewCtrl", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogoutButtonPressed(_ sender: Any) {
        TwitterClient.sharedInstance?.logout()
    }
    
    @IBAction func onProfileImgPressed(_ sender: UIButton) {
        self.segueIndex = sender.tag
        performSegue(withIdentifier: "segueToProfileViewCtrl", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "segueToTweetDetailViewCtrl" {
            let destViewCtrl = segue.destination as! TweetDetailsViewController
            destViewCtrl.tweet = self.tweets[self.segueIndex]
        } else if segue.identifier == "segueToProfileViewCtrl" {
            let destViewCtrl = segue.destination as! ProfileViewController
            destViewCtrl.tweet = self.tweets[self.segueIndex]
        }
    }

}
