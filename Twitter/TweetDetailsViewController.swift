//
//  TweetDetailsViewController.swift
//  Twitter
//
//  Created by Edison Lam on 3/1/17.
//  Copyright © 2017 Edison Lam. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController {

    var tweet: Tweet! = nil
    
    @IBOutlet weak var profileView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screen_nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favCountLabel: UILabel!
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var retweetBtn: UIButton!
    @IBOutlet weak var replyBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if tweet != nil {
            profileView.setImageWith(tweet.profileImageUrl!)
            profileView.layoutIfNeeded()
            profileView.layer.cornerRadius = 3
            profileView.clipsToBounds = true
            
            nameLabel.text = tweet.name!
            screen_nameLabel.text = "@\(tweet.screen_name!)"
            statusLabel.text = tweet.text!
            timestampLabel.text = tweet.timestampString
            retweetCountLabel.text = "\(tweet.retweetCount)"
            favCountLabel.text = "\(tweet.favoritesCount)"
            
            if tweet.isRetweeted { retweetBtn.setBackgroundImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal) }
            if tweet.isFavorited { favBtn.setBackgroundImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal) }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onReplyBtnPressed(_ sender: Any) {
    }
    
    @IBAction func onRetweetBtnPressed(_ sender: Any) {
        toggleRetweet(!tweet.isRetweeted, isPost:true)
    }
    
    @IBAction func onFavBtnPressed(_ sender: Any) {
        toggleFavorited(!tweet.isRetweeted, isPost:true)
    }
    
    func toggleRetweet(_ flag: Bool, isPost: Bool = false) {
        tweet.isRetweeted = flag
        
        if (flag) {
            retweetBtn.setBackgroundImage(#imageLiteral(resourceName: "retweet-icon-green"), for: UIControlState.normal)
            tweet.retweetCount += 1
            retweetCountLabel.text = "\(tweet.retweetCount)"
            if (isPost) { TwitterClient.sharedInstance?.statusRetweet(tweet.id_str!) }
        } else {
            retweetBtn.setBackgroundImage(#imageLiteral(resourceName: "retweet-icon"), for: UIControlState.normal)
            tweet.retweetCount = tweet.retweetCount==0 ? 0 : tweet.retweetCount - 1
            retweetCountLabel.text = tweet.retweetCount==0 ? "" : "\(tweet.retweetCount)"
            if (isPost) { TwitterClient.sharedInstance?.statusUnretweet(tweet.id_str!) }
        }
    }
    
    func toggleFavorited(_ flag: Bool, isPost: Bool = false) {
        tweet.isFavorited = flag
        
        if (flag) {
            favBtn.setBackgroundImage(#imageLiteral(resourceName: "favor-icon-red"), for: UIControlState.normal)
            tweet.favoritesCount += 1
            favCountLabel.text = "\(tweet.favoritesCount)"
            if (isPost) {TwitterClient.sharedInstance?.favoritesCreate(tweet.id_str!)}
        } else {
            favBtn.setBackgroundImage(#imageLiteral(resourceName: "favor-icon"), for: UIControlState.normal)
            tweet.favoritesCount = tweet.favoritesCount==0 ? 0 : tweet.favoritesCount - 1
            favCountLabel.text = tweet.favoritesCount==0 ? "" : "\(tweet.favoritesCount)"
            if (isPost) {TwitterClient.sharedInstance?.favoritesDestroy(tweet.id_str!)}
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
