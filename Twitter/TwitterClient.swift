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
    
    // login closure variables
    var loginSuccess: (()->())?
    var loginFailure: ((Error)->())?
    
    
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
    
    // Refactor to use closures
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (Error) -> ()) {
        // GET request to get User Profile Settings
        self.get("1.1/account/verify_credentials.json", parameters: nil, success: { (task: URLSessionDataTask, response: Any) in
            print("\nSuccess verify credentials\n")
            
            //print("account: \(response)")
            let userDictionary = response as? NSDictionary
            
            let user = User(dictionary: userDictionary!)
            
            success(user)
            
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        })
    }
    
    
    /** Refactor login portion between LoginViewController & AppDelegate
     *
     */
    func login(success: @escaping ()->(), failure: @escaping (Error)->()) {
        self.loginSuccess = success
        self.loginFailure = failure
        
        
        // BDBOAuth1Manager was reported to be buggy
        // calling deauthorize() prior to requests is a workaround to flush out prior sessions
        self.deauthorize()
        
        // 2. request a token
        // callbackURL twitter://oauth is something we define, the "URL Scheme"
        // it's defined at the Project overview, using the "Bundle Identifier" and defining at the "Info" Tab
        self.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "twitter://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential?) in
            //print("I got a token!")
            //print(requestToken?.token ?? "Bad requestToken")
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken?.token ?? "")")!
            
            // 3. open the url in browser to authenticate
            UIApplication.shared.open(url as URL, options: [:], completionHandler: { (true) in
                //print("Successfully opened url.")
            })
            
        }, failure: { (error: Error?) -> Void in
            //print("Failed to get request token")
            //print("error: \(error?.localizedDescription)")
            
            // if we failed, pass along the error
            self.loginFailure!(error!)
        })
    }
    
    
    /** AppDelegate receives callBackURL and invokes this method to finish the login process */
    func handleOpenUrl(url: URL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        self.fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential?) -> Void in
            
            self.loginSuccess?()
            
            //print("\nI got the access token!")
            //print("\(accessToken?.token)")
        }, failure: { (error: Error?) -> Void in
            print("error: \(error?.localizedDescription)")
            self.loginFailure?(error!)
        })
    }
    
}
