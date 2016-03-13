//
//  TweetCellTableViewCell.swift
//  Twitter Demo
//
//  Created by Sumaiya Mansur on 3/12/16.
//  Copyright © 2016 Pearsman. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var likeCount: UIButton!
    @IBOutlet weak var retweetCount: UIButton!
    @IBOutlet weak var timestampLabel: UILabel!
    
    var id: String = ""
    
    var tweet: Twitter! {
        
        didSet {
           profileImage.setImageWithURL((tweet.user?.profileUrl!)!)
           nameLabel.text = tweet.user?.name
           userLabel.text = tweet.user?.screenname
           tweetLabel.text = tweet.text
           likeLabel.text = String(tweet.favCount)
           retweetLabel.text = String(tweet.retweetCount)
            //id = tweet.num
        }       //timestampLabel.text = tweetTime(tweet.timestamp!.timeIntervalSinceNow)
    
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
                // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
