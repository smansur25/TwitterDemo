//
//  Twitter.swift
//  Twitter Demo
//
//  Created by Sumaiya Mansur on 3/1/16.
//  Copyright © 2016 Pearsman. All rights reserved.
//

import UIKit

class Twitter: NSObject {
    

    var user: User?
    var text: String?
    var timestamp: NSDate?
    var retweetCount: Int = 0
    var followersCount: Int = 0
    var favCount: Int = 0
    var friendsCount: Int = 0
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as! Int) ?? 0
        followersCount = (dictionary["followers_count"] as? Int) ?? 0
        favCount = (dictionary["favourites_count"] as? Int) ?? 0
        friendsCount = (dictionary["friends_count"] as? Int) ?? 0
        user = User(dictionary: dictionary ["user"] as! NSDictionary)
     
        let timestampString = dictionary["created_at"] as? String
        if let timestampString = timestampString {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss: Z y"
        timestamp = formatter.dateFromString(timestampString)
            
        }
        
        }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Twitter]{
    var tweets = [Twitter]()
        for dictionary in dictionaries {
            let tweet = Twitter(dictionary: dictionary)
            tweets.append(tweet)
        }
        
        return tweets
    
    }
}



