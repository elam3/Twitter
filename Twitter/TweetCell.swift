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
            timestampLabel.text = "\u{B7} \(tweet.timestamp!)"
            tweetLabel.text = tweet.text
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
