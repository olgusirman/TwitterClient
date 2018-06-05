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
}
