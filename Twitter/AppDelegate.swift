//
//  AppDelegate.swift
//  Twitter
//
//  Created by Edison Lam on 2/17/17.
//  Copyright © 2017 Edison Lam. All rights reserved.
//

import UIKit
import BDBOAuth1Manager // added to handle the callBackURL

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    /** In the OAuth handshake, the callBackURL comes home via the 'unique protocol' we created to handle i.e. mytwitterdemo://oauth,
     *  we can call this function to capture the reponse.
     */
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        print(url.description)
        
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        let twitterClient = BDBOAuth1SessionManager(baseURL: URL(string: "https://api.twitter.com"), consumerKey: "EScjTh3gK34tM7zKV6ugLxK1B", consumerSecret: "457mghv1TwkSr6gHvUqyU2hYInIBuaotz6ngKOYb7jfx0aZCkX")
        
        
        twitterClient?.fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential?) -> Void in
            
            print("I got the access token!")
            print("\(accessToken?.token)")
            
            // GET request to get User Profile Settings
            twitterClient?.get("1.1/account/verify_credentials.json", parameters: nil, success: { (task: URLSessionDataTask, response: Any) in
                print("Success verify credentials")
                
                //print("account: \(response)")
                let user = response as? NSDictionary
                
                /*if let name: String = user["name"] {
                    print("name: \(name)")
                }*/
                
                print("name: \(user?["name"] ?? "")")
                
            }, failure: { (task: URLSessionDataTask?, error: Error) in
                print("Failed verify credentials")
                print("error: \(error.localizedDescription)")
            })
            
            
            // GET request to get home timeline
            twitterClient?.get("1.1/statuses/home_timeline.json", parameters: nil, success: { (task: URLSessionDataTask, response: Any) in
                print("Success got home timeline")
                let timeline = response as? NSDictionary
                
                //print(response)
                
            }, failure: { (task: URLSessionDataTask?, error: Error) in
                print("Failed to get home timeline")
                print("error: \(error.localizedDescription)")
            })
            
            
        }, failure: { (error: Error?) -> Void in
            print("error: \(error?.localizedDescription)")
        })
        
        return true
    }


}

