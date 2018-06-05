//
//  Tweet.swift
//  VNGRSTwitterClient
//
//  Created by Olgu SIRMAN on 30.05.2018.
//  Copyright © 2018 Olgu SIRMAN. All rights reserved.
//

import Foundation
import ObjectMapper

final class Tweet: Mappable {
    
    var created: String?
    var id: Int?
    var id_str: String?
    var text: String?
    var entities: Entity?
    var user: User?
    var indexPath: IndexPath?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        self.created <- map["created_at"]
        self.id  <- map["id"]
        self.id_str <- map["id_str"]
        self.text <- map["text"]
        self.entities <- map["entities"]
        self.user <- map["user"]
    }
}

extension Tweet {
    
    var hasImage: Bool {
        
        guard let entity = entities,
            let media = entity.media?.first,
            let mediaUrl = media.mediaUrl,
            URL(string: mediaUrl) != nil else {
                return false
        }
        return true
    }
    
    func configureCellHeight() -> CGFloat {
        guard let entity = entities,
            let media = entity.media?.first,
            let mediaUrl = media.mediaUrl,
            let size = media.sizes?.medium,
            let text = text,
            URL(string: mediaUrl) != nil else {
                return UITableViewAutomaticDimension
        }
        
        guard let heigth = size.height,
            let width = size.width else {
                return UITableViewAutomaticDimension
        }
        
        let fWidth = Float(width)
        let fHeight = Float(heigth)
        let ratio = fWidth / fHeight
        
        // Find text size +
        // Static Constraints numbers +
        // Image Ratio Height < 300 etc
        
        let screenWidth = UIScreen.main.bounds.size.width
        let profileImageWidth = screenWidth * 0.13
        
        // leftPadding + profileImage + 8 + text + rightPadding
        // 15 + profileImageWidth + 8 + text + 15
        let textWidth: CGFloat = screenWidth - ( 33 + profileImageWidth )
        let textHeight = UIFont.systemFont(ofSize: 17).sizeOfString(string: text, constrainedToWidth: textWidth).height
        
        // Check the aspectRatio width and height and configure optimum height
        // If the width >1, consider textWidth
        let optimumHeight = textWidth / CGFloat(ratio)
        let imageRatioHeight: CGFloat
        if ratio >= 1 {
            imageRatioHeight = optimumHeight
        } else {
            // If the width <1, check max optimumHeight should be 300
            imageRatioHeight = min(optimumHeight, 300)
        }
        
        // Check labelHeight and profileImageHeight, use the bigger one
        let labelOrProfileHeight = max(textHeight, profileImageWidth)
        
        // Top + labelOrProfileHeight + labelBottom + imageRatioHeight + bottom
        // 8 + labelOrProfileHeight + 8 + imageRatioHeight + 8
        return (24 + labelOrProfileHeight + imageRatioHeight)
    }
}
