//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Edison Lam on 2/18/17.
//  Copyright © 2017 Edison Lam. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {

    var tweets: [Tweet]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // GET request to get home timeline
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            
            for tweet in tweets {
                print("\(tweet.text ?? "")")
            }
        }, failure: { (error: Error) in
            print("Failed to get home timeline")
            print("error: \(error.localizedDescription)")
        })

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

}
