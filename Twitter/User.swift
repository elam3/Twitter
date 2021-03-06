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
    
    // Add a static constant to replace error-prone string literal
    static let userDidLogoutNotification = "UserDidLogout"
    
    // serialize user data back into a JSON for persistance
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
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
    
    /** login persistance
     *  the static variable, _currentUser, serves as a placeholder
     */
    static var _currentUser: User?
    
    class var currentUser: User? {
        get {
            
            if _currentUser == nil {
                // make a UserDefaults, i.e. the "browser cookie" for apps
                let defaults = UserDefaults.standard
                let userData = defaults.object(forKey: "currentUserData") as? Data
            
                if let userData = userData {
                    if let dict = try? JSONSerialization.jsonObject(with: userData as Data, options: []) as! NSDictionary {
                    _currentUser = User(dictionary: dict)
                        print("userCurrentData RETRIEVED!")
                    } else {
                        _currentUser = nil
                    }
                }
            }
            
            return _currentUser
        }
        
        set(user) {
            _currentUser = user
            let defaults = UserDefaults.standard
            
            if let user = _currentUser {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary ?? [], options: [])
                defaults.set(data, forKey: "currentUserData")
                print("currentUserData SAVED!")
            } else {
                defaults.set(nil, forKey: "currentUserData")
                print("currentUserData RESET to nil!")
            }
            
            defaults.synchronize()
        }
    }
    
}
