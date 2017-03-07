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
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screen_nameLabel: UILabel!
    
    var tweet: Tweet! = nil
    var isReply: Bool = false
    var replyTo: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.barTintColor = UIColor.white
        
        tweetTextView.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        profileImageView.setImageWith(tweet.profileImageUrl!)
        nameLabel.text = tweet.name!
        screen_nameLabel.text = "@\(tweet.screen_name!)"
        tweetTextView.textColor = UIColor.gray
    }
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        textView.textColor = UIColor.black
        if isReply {
            textView.text = "@" + tweet.screen_name! + " "
        } else {
            textView.text = ""
        }
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        onTweetButtonPressed(textView)
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        tweetCharLimitButton.title = "\(140-tweetTextView.text.characters.count)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onTweetButtonPressed(_ sender: Any) {
        if !isReply {
            //print("tweetTextView.text: \(tweetTextView.text!)")
            TwitterClient.sharedInstance?.statusUpdate(tweetTextView.text!)
        } else {
            //print("tweetTextView.text: \(tweetTextView.text!)")
            print("Reply Tweet: \(tweet.id_str!)")
            TwitterClient.sharedInstance?.statusReply(tweetTextView.text!, id_str: tweet.id_str!)
        }
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
