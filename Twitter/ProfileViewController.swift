//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Edison Lam on 3/1/17.
//  Copyright © 2017 Edison Lam. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var tweet: Tweet! = nil
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screen_nameLabel: UILabel!
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewDidAppear(false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let user = tweet.user as! NSDictionary
        
        if tweet.isUseProfileBgImg {
            print("ProfBgImgStr: \(user["profile_background_image_url_https"]!)")
            backgroundImageView.setImageWith(tweet.profileBgImgUrl!)
        }
        
        
        profileImageView.setImageWith(tweet.profileImageUrl!)
        profileImageView.layoutIfNeeded()
        profileImageView.layer.cornerRadius = 3
        profileImageView.clipsToBounds = true
        
        nameLabel.text = "\(tweet.name!)"
        screen_nameLabel.text = "@\(tweet.screen_name!)"
        tweetCountLabel.text = "\(user["statuses_count"]!)"
        followingCountLabel.text = "\(user["friends_count"]!)"
        followersCountLabel.text = "\(user["followers_count"]!)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
