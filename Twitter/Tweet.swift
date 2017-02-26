//
//  Tweet.swift
//  Twitter
//
//  Created by Edison Lam on 2/18/17.
//  Copyright © 2017 Edison Lam. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    let user: NSObject?
    let text: String?
    var timestamp: String?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    //let profileImageUrlString: String?
    let profileImageUrl: URL?
    let name: String?
    let screen_name: String?
    
    init(dictionary: [String: AnyObject]) {
        text = dictionary["text"] as? String
        user = dictionary["user"] as! NSDictionary
        name = dictionary["user"]?["name"] as? String
        screen_name = dictionary["user"]?["screen_name"] as? String
        
        let profileImageUrlString = dictionary["user"]?["profile_image_url_https"] as? String
        if profileImageUrlString != nil {
            profileImageUrl = URL(string: profileImageUrlString!)!
            //print("profileImageUrlString: \(profileImageUrlString!)")
        } else {
            profileImageUrl = nil
        }
        
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        
        let timeStampString = dictionary["created_at"] as? String
        timestamp = timeStampString
        /*if let timeStampString = timeStampString {
            let formatter = DateFormatter()
            formatter.setLocalizedDateFormatFromTemplate("EEE MMM d HH:mm:ss Z y")
            timestamp = formatter.string(from: formatter.date(from: timeStampString)!)
        }*/
        
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary as! [String : AnyObject])
            tweets.append(tweet)
        }
        
        return tweets
    }
    
}
