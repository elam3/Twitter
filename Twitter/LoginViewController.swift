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
        
        twitterClient?.login(success: { 
            //print("Successfully logged in!")
            
            // After creating an embedded navigation,
            // and hooking the login nav controller to the new view controller in modal presentation
            // we want to segueway to the home timeline
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
        }, failure: { (error: Error) in
            print("error: \(error.localizedDescription)")
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
