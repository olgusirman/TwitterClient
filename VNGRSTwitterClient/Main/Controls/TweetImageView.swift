//
//  TweetImageView.swift
//  VNGRSTwitterClient
//
//  Created by Olgu on 3.06.2018.
//  Copyright © 2018 Olgu SIRMAN. All rights reserved.
//

import UIKit
import AlamofireImage
import Kingfisher

final class TweetImageView: UIImageView {
        
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var aspectRatioConstraint: NSLayoutConstraint!
    
    fileprivate var entity: Entity?
    
    func setImage(to tweet: Tweet) {
        guard let entity = tweet.entities,
            let media = entity.media?.first,
            let mediaUrl = media.mediaUrl,
            let url = URL(string: mediaUrl) else {
                imageHeightConstraint.constant = 0
                self.superview?.layoutIfNeeded()
                return
        }
        self.entity = entity
        //        self.image = nil
        self.af_setImage(withURL: url)
        debugPrint(url)
        self.superview?.layoutIfNeeded()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        guard let entity = entity,
            let media = entity.media?.first,
            let mediaUrl = media.mediaUrl,
            let size = media.sizes?.medium,
            URL(string: mediaUrl) != nil && self.image != nil else {
                return
        }
        
        guard let heigth = size.height,
            let width = size.width else {
                return
        }
        let aspectRatio: CGFloat = CGFloat(width / heigth)
        
        self.aspectRatioConstraint.isActive = false
        self.aspectRatioConstraint = self.widthAnchor.constraint( equalTo: self.heightAnchor, multiplier: aspectRatio)
        self.aspectRatioConstraint.isActive = true
    }
}
