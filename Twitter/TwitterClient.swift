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
    
    /** Mark a tweet with a "favorited" status 
     *  https://dev.twitter.com/rest/reference/post/favorites/create
     *  Resource URL :          https://api.twitter.com/1.1/favorites/create.json
     *  Example RequestPOST :   https://api.twitter.com/1.1/favorites/create.json?id=243138128959913986
     */
    func favoritesCreate(_ id_str: String) {
        self.post("1.1/favorites/create.json?id=" + id_str, parameters: nil, success: { (task: URLSessionDataTask, response: Any) in
            print("Favorited post id: " + id_str)
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            print("favoritesCreate error: \(error.localizedDescription)")
        })
    }
    
    /** Mark a tweet with a "Un-favorited" status
     *  https://dev.twitter.com/rest/reference/post/favorites/destroy
     *  Resource URL :          https://api.twitter.com/1.1/favorites/destroy.json
     *  Example Request : POST  https://api.twitter.com/1.1/favorites/destroy.json?id=243138128959913986
     */
    func favoritesDestroy(_ id_str: String) {
        self.post("1.1/favorites/destroy.json?id=" + id_str, parameters: nil, success: { (task: URLSessionDataTask, response: Any) in
            print("Un-Favorited post id: " + id_str)
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            print("favoritesDestroy error: \(error.localizedDescription)")
        })
    }
    
    /** Retweets a tweet. Returns the original tweet with retweet details embedded.
     *  https://dev.twitter.com/rest/reference/post/statuses/retweet/%3Aid
     *  Resource URL :          https://api.twitter.com/1.1/statuses/retweet/:id.json
     *  Example Request : POST  https://api.twitter.com/1.1/statuses/retweet/243149503589400576.json
     */
    func statusRetweet(_ id_str: String) {
        self.post("1.1/statuses/retweet/"+id_str+".json", parameters: nil, success: { (task: URLSessionDataTask, response: Any) in
            print("Re-Tweet post id: " + id_str)
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            print("Re-Tweet error: \(error.localizedDescription)")
        })
    }
    
    /** Untweets a retweeted status. Returns the original Tweet with retweet details embedded.
     *  https://dev.twitter.com/rest/reference/post/statuses/unretweet/id
     *  Resource URL :          https://api.twitter.com/1.1/statuses/unretweet/:id.json
     *  Example Request : POST  https://api.twitter.com/1.1/statuses/retweet/241259202004267009.json
     */
    func statusUnretweet(_ id_str: String) {
        self.post("1.1/statuses/unretweet/"+id_str+".json", parameters: nil, success: { (task: URLSessionDataTask, response: Any) in
            print("Un-Retweet post id: " + id_str)
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            print("Un-Retweet error: \(error.localizedDescription)")
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
    
    /** onLogoutBtn from TweetsViewController triggers an button pressed action to call this method */
    func logout() {
        deauthorize()
        User.currentUser = nil
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.userDidLogoutNotification), object: nil)
    }
    
    
    /** AppDelegate receives callBackURL and invokes this method to finish the login process */
    func handleOpenUrl(url: URL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        self.fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential?) -> Void in
            
            self.currentAccount(success: { (user: User) in
                
                // call the setter & saves the user
                User.currentUser = user
                self.loginSuccess?()
                print("loginSuccess?()")
                
            }, failure: { (error: Error) in
                
                self.loginFailure?(error)
                
            })
            
            //print("\nI got the access token!")
            //print("\(accessToken?.token)")
        }, failure: { (error: Error?) -> Void in
            print("error: \(error?.localizedDescription)")
            self.loginFailure?(error!)
        })
    }
    
}
