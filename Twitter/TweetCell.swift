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
        }
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
