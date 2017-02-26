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
    var timestamp: Date?
    var timestampString: String?
    let profileImageUrl: URL?
    let name: String?
    let screen_name: String?
    
    var replyCount: Int = 0
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    
    var isRetweeted: Bool
    var isFavorited: Bool
    
    init(dictionary: [String: AnyObject]) {
        text = dictionary["text"] as? String
        user = dictionary["user"] as! NSDictionary
        name = dictionary["user"]?["name"] as? String
        screen_name = dictionary["user"]?["screen_name"] as? String
        
        // Profile Image
        let profileImageUrlString = dictionary["user"]?["profile_image_url_https"] as? String
        if profileImageUrlString != nil {
            profileImageUrl = URL(string: profileImageUrlString!)!
        } else {
            profileImageUrl = nil
        }
        
        //TODO Add replyCount
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        
        isRetweeted = (dictionary["retweeted"] as? Bool) ?? false
        isFavorited = (dictionary["favorited"] as? Bool) ?? false
        
        let myFormatter = DateFormatter()
        timestampString = dictionary["created_at"] as? String
        timestamp = myFormatter.date(from: timestampString!)

        
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
