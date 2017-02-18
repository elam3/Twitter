//
//  TwitterClient.swift
//  Twitter
//
//  Created by Edison Lam on 2/18/17.
//  Copyright © 2017 Edison Lam. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {

    static let sharedInstance = TwitterClient(baseURL: URL(string: "https://api.twitter.com"), consumerKey: "EScjTh3gK34tM7zKV6ugLxK1B", consumerSecret: "457mghv1TwkSr6gHvUqyU2hYInIBuaotz6ngKOYb7jfx0aZCkX")
    
    // The request has to act asynchronously,
    // so that's why we were using closures to execute chunks of code
    // in order to maintain that, we need to pass in closures as an argument
    func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        
        // GET request to get home timeline
        self.get("1.1/statuses/home_timeline.json", parameters: nil, success: { (task: URLSessionDataTask, response: Any) in
            print("Success got home timeline")
            let dictionaries = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            
            // upon success, send back the tweets
            success(tweets)

            
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            
            // similarly for failure, send back the error
            failure(error)
        })
    }
    
    func currentAccount() {
        // GET request to get User Profile Settings
        self.get("1.1/account/verify_credentials.json", parameters: nil, success: { (task: URLSessionDataTask, response: Any) in
            print("\nSuccess verify credentials\n")
            
            //print("account: \(response)")
            let userDictionary = response as? NSDictionary
            
            let user = User(dictionary: userDictionary!)
            
            print("name: \(user.name ?? "")")
            print("screenname: \(user.screenname ?? "")")
            print("profile url: \(user.profileUrl)")
            print("description: \(user.tagline ?? "")")
            
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            print("Failed verify credentials")
            print("error: \(error.localizedDescription)")
        })
    }
    
}
