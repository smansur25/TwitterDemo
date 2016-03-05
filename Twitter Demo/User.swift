//
//  User.swift
//  Twitter Demo
//
//  Created by Nusrat Akhter on 3/1/16.
//  Copyright © 2016 Pearsman. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: NSString?
    var screenname:NSString?
    var profileUrl: NSURL?
    var tagline: NSString?
    var followersCount: Int = 0
    var favouritesCount: Int = 0
    var friendsCount: Int = 0
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        followersCount = (dictionary["friends_count"] as? Int) ?? 0
        favouritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        friendsCount = (dictionary["friends_count"] as? Int) ?? 0
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = NSURL (string: profileUrlString)
        }
        
        tagline = dictionary["description"] as? String
        

}
    static  var _currentUser: User?
    
    
    class var currentUser: User? {
        get {
        
            if _currentUser == nil {
            let defaults = NSUserDefaults.standardUserDefaults()
            let userData = defaults.objectForKey("currentUserData") as? NSData
            if let userData = userData {
                let dictionary = try! NSJSONSerialization.dataWithJSONObject(userData, options: []) as! NSDictionary
                  _currentUser = User(dictionary: dictionary)
                }
        }
            
            return _currentUser
        }
        
        set(user) {
            let defaults = NSUserDefaults.standardUserDefaults()
            if let user = user {
            let data = try! NSJSONSerialization.dataWithJSONObject(user.dictionary!, options: [])
                defaults.setObject(data, forKey: "currentUserData")
            } else {
            defaults.setObject(nil, forKey: "currentUserData")
                
            }
            
            defaults.synchronize()
        }
}
    
}