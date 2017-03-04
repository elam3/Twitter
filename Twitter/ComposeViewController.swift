//
//  ComposeViewController.swift
//  Twitter
//
//  Created by Edison Lam on 3/1/17.
//  Copyright © 2017 Edison Lam. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate{

    @IBOutlet weak var tweetCharLimitButton: UIBarButtonItem!
    @IBOutlet weak var tweetTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.barTintColor = UIColor.white
        
        tweetTextView.delegate = self
    }

    /* TODO
        - disable input after 140 characters
        - grey initial text "What's happenning?"
     */
    
    public func textViewDidChange(_ textView: UITextView) {
        tweetCharLimitButton.title = "\(140-tweetTextView.text.characters.count)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onTweetButtonPressed(_ sender: Any) {
        //print("tweetTextView.text: \(tweetTextView.text!)")
        TwitterClient.sharedInstance?.statusUpdate(tweetTextView.text!)
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
