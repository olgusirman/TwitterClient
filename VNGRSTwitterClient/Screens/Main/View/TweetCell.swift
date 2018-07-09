//
//  TweetCell.swift
//  VNGRSTwitterClient
//
//  Created by Olgu SIRMAN on 31.05.2018.
//  Copyright © 2018 Olgu SIRMAN. All rights reserved.
//

import UIKit
import AlamofireImage

final class TweetCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet fileprivate weak var userImageView: UserProfileImageView!
    @IBOutlet fileprivate weak var tweetTextLabel: UILabel!
    @IBOutlet weak var entityImageView: TweetImageView!
    
    weak var delegate: TweetCellDelegate?
    
    // MARK: Lifecycle
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        userImageView.roundCorners()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        userImageView.image = nil
    }
    
    // MARK: Configure
    func configure(tweet: Tweet) {
        tweetTextLabel.text = tweet.text
        tweet.user?.setImage(to: userImageView)
        
        if tweet.entities?.media?.first?.mediaUrl != nil {
            self.entityImageView.setImage(to: tweet, completionHandler: { [weak self] in
                self?.delegate?.imageLoaded(with: nil, with: tweet.indexPath)
            })
        }
    }
}
