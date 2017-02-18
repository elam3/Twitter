//
//  User.swift
//  Twitter
//
//  Created by Edison Lam on 2/18/17.
//  Copyright © 2017 Edison Lam. All rights reserved.
//

import UIKit

class User: NSObject {

    var name: NSString?
    var screenname: NSString?
    var profileUrl: NSURL?
    var tagline: NSString?
    
    init(dictionary: NSDictionary) {
        name = dictionary["name"] as? String as NSString?
        screenname = dictionary["screen_name"] as? String as NSString?
        tagline = dictionary["description"] as? String as NSString?
        
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = NSURL(string: profileUrlString)
        } else {
            profileUrl = NSURL(string: "")
        }

    }
    
}
