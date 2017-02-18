//
//  LoginViewController.swift
//  Twitter
//
//  Created by Edison Lam on 2/17/17.
//  Copyright © 2017 Edison Lam. All rights reserved.
//

import UIKit
import BDBOAuth1Manager // 0. import to make OAuth requests

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 00. wire an action from a button on storyboard
    @IBAction func onLoginButton(_ sender: Any) {
        // 1. create a session
        let twitterClient = TwitterClient.sharedInstance
        
        // BDBOAuth1Manager was reported to be buggy
        // calling deauthorize() prior to requests is a workaround to flush out prior sessions
        twitterClient?.deauthorize()
        
        // 2. request a token
        // callbackURL twitter://oauth is something we define, the "URL Scheme"
        // it's defined at the Project overview, using the "Bundle Identifier" and defining at the "Info" Tab
        twitterClient?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "twitter://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential?) in
            print("I got a token!")
            print(requestToken?.token ?? "Bad requestToken")
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken?.token ?? "")")!
            
            // 3. open the url in browser to authenticate
            UIApplication.shared.open(url as URL, options: [:], completionHandler: { (true) in
                print("Successfully opened url.")
            })
            
        }, failure: { (error: Error?) -> Void in
            print("Failed to get request token")
            print("error: \(error?.localizedDescription)")
        })
        
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
