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
    
    func setImage(to tweet: Tweet, completionHandler: (() -> Void)? = nil ) {
        guard let entity = tweet.entities,
            let media = entity.media?.first,
            let mediaUrl = media.mediaUrl,
            let url = URL(string: mediaUrl) else {
                imageHeightConstraint.constant = 0
                //self.layoutIfNeeded()
                return
        }
        self.entity = entity
        //self.af_setImage(withURL: url)
        self.af_setImage(withURL: url) { (dataResponse) in
            completionHandler?()
        }
        //self.layoutIfNeeded()
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
        
        let fWidth = Float(width)
        let fHeight = Float(heigth)
        let ratio = fWidth / fHeight
        let aspectRatio: Float = roundf(ratio * 100) / 100
        
        self.aspectRatioConstraint.isActive = false
        self.aspectRatioConstraint = self.widthAnchor.constraint( equalTo: self.heightAnchor, multiplier: CGFloat(aspectRatio))
        self.aspectRatioConstraint.isActive = true
    }
}
