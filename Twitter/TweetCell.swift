//
//  TweetCell.swift
//  Twitter
//
//  Created by Edison Lam on 2/25/17.
//  Copyright © 2017 Edison Lam. All rights reserved.
//
import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screen_nameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var replyCountLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favCountLabel: UILabel!
    @IBOutlet weak var retweetedButton: UIButton!
    @IBOutlet weak var favoritedButton: UIButton!
    
    var profileImageUrlString: String?
    
    var tweet : Tweet! {
        didSet {
            //initialize instance data members
            
            profileImageView.setImageWith(tweet.profileImageUrl!)
            //cornerRadius
            profileImageView.layoutIfNeeded()
            profileImageView.layer.cornerRadius = 3
            profileImageView.clipsToBounds = true
            
            nameLabel.text = tweet.name
            screen_nameLabel.text = "@\(tweet.screen_name!)"
            timestampLabel.text = "\u{B7} \(tweet.timestampString!)"
            tweetLabel.text = tweet.text
            
            replyCountLabel.text = tweet.replyCount==0 ? "" : "\(tweet.replyCount)"
            retweetCountLabel.text = tweet.retweetCount==0 ? "" : "\(tweet.retweetCount)"
            favCountLabel.text = tweet.favoritesCount==0 ? "" : "\(tweet.favoritesCount)"
            
            toggleRetweet(tweet.isRetweeted)
            toggleFavorited(tweet.isFavorited)
        }
    }
    
    
    
    func toggleRetweet(_ flag: Bool) {
        tweet.isRetweeted = flag
        
        if (flag) {
            retweetedButton.setBackgroundImage(#imageLiteral(resourceName: "retweet-icon-green"), for: UIControlState.normal)
            tweet.retweetCount += 1
            retweetCountLabel.text = "\(tweet.retweetCount)"
        } else {
            retweetedButton.setBackgroundImage(#imageLiteral(resourceName: "retweet-icon"), for: UIControlState.normal)
            tweet.retweetCount = tweet.retweetCount==0 ? 0 : tweet.retweetCount - 1
            retweetCountLabel.text = tweet.retweetCount==0 ? "" : "\(tweet.retweetCount)"
        }
    }
    
    @IBAction func onRetweetBtnPressed(_ sender: Any) {
        toggleRetweet(!tweet.isRetweeted)
    }
    
    func toggleFavorited(_ flag: Bool, isPost: Bool = false) {
        tweet.isFavorited = flag
        
        if (flag) {
            favoritedButton.setBackgroundImage(#imageLiteral(resourceName: "favor-icon-red"), for: UIControlState.normal)
            tweet.favoritesCount += 1
            favCountLabel.text = "\(tweet.favoritesCount)"
            if (isPost) {TwitterClient.sharedInstance?.favoritesCreate(tweet.id_str!)}
        } else {
            favoritedButton.setBackgroundImage(#imageLiteral(resourceName: "favor-icon"), for: UIControlState.normal)
            tweet.favoritesCount = tweet.favoritesCount==0 ? 0 : tweet.favoritesCount - 1
            favCountLabel.text = tweet.favoritesCount==0 ? "" : "\(tweet.favoritesCount)"
            if (isPost) {TwitterClient.sharedInstance?.favoritesDestroy(tweet.id_str!)}
        }
    }
    
    @IBAction func onFavBtnPressed(_ sender: Any) {
        toggleFavorited(!tweet.isFavorited, isPost:true)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
