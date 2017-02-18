//
//  LoginViewController.swift
//  Twitter
//
//  Created by Edison Lam on 2/17/17.
//  Copyright © 2017 Edison Lam. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    @IBAction func onLoginButton(_ sender: Any) {
        let twitterClient = BDBOAuth1SessionManager(baseURL: URL(string: "https://api.twitter.com"), consumerKey: "EScjTh3gK34tM7zKV6ugLxK1B", consumerSecret: "457mghv1TwkSr6gHvUqyU2hYInIBuaotz6ngKOYb7jfx0aZCkX")
        
        twitterClient?.deauthorize()
        twitterClient?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "twitter://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential?) in
            print("I got a token!")
            print(requestToken?.token ?? "Bad requestToken")
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken?.token ?? "")")!
            UIApplication.shared.open(url as URL, options: [:], completionHandler: { (true) in
                print("Successfully opened url.")
            })
            
        }, failure: { (error: Error?) -> Void in
            print("error: \(error?.localizedDescription)")
        })
        
    }

}
