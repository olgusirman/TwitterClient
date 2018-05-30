//
//  TweetCell.swift
//  VNGRSTwitterClient
//
//  Created by Olgu SIRMAN on 31.05.2018.
//  Copyright © 2018 Olgu SIRMAN. All rights reserved.
//

import UIKit

final class TweetCell: UITableViewCell {
    
    @IBOutlet fileprivate weak var tweetTextLabel: UILabel!
    
    func configure(tweet: Tweet) {
        tweetTextLabel.text = tweet.text
    }
    
}
