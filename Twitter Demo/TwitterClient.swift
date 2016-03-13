//
//  TwitterClient.swift
//  Twitter Demo
//
//  Created by Sumaiya Mansur on 3/2/16.
//  Copyright © 2016 Pearsman. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
        
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")!, consumerKey: "K0Y1t8w60ftP9UAA7L0AYXiJ8", consumerSecret: "XDdHHJjG6kzUC5xDyrrVLTjeFrI9373hA0hKbd5YNHlh0pUjKO")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) -> ())?
    
    func login(sucess: () -> (), failure: (NSError) -> ()) {
        loginSuccess = sucess
        loginFailure = failure
        
        TwitterClient.sharedInstance.deauthorize()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
            UIApplication.sharedApplication().openURL(url)
            
            }) { (error:NSError!) -> Void in
                print ("error :\(error.localizedDescription)")
                self.loginFailure?(error)
        }
}
    func logout() {
        User.currentUser = nil
        deauthorize()
        NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogoutNotification, object: nil)
    }
    
    func handleOpenUrl(url: NSURL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential!) -> Void in
            
            self.credentials({ (user: User) -> () in
                 self.loginSuccess?()
                User.currentUser = user
                }, faliure: { (error: NSError) -> () in
                    
                    self.loginFailure?(error)
            })
            
            }) { (error: NSError!) -> Void in
                print("error: \(error.localizedDescription)")
                self.loginFailure?(error)

                   }
}

    
    func homeTimeline(success: ([Twitter]) -> (), failure: (NSError) -> ()) {
        
        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let dictionaries = response as! [NSDictionary]
            let tweets = Twitter.tweetsWithArray(dictionaries)
           
                success(tweets)
            print("tweets")
            }, failure: { (task: NSURLSessionDataTask?, error:NSError) -> Void in
                
                failure(error)
        })
        }
    
    func credentials(success: (User) -> (), faliure: (NSError) -> ()) {
        
        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            
            let userDictionary = response as! NSDictionary
            
            let user = User(dictionary: userDictionary)
            success(user)
            
            }, failure: { (task: NSURLSessionDataTask?, error:NSError) -> Void in
            
                
        })
        
        
    }
    


}


