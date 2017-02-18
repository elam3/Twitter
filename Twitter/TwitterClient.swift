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
    
    
}
