//
//  Media.swift
//  VNGRSTwitterClient
//
//  Created by Olgu SIRMAN on 30.05.2018.
//  Copyright © 2018 Olgu SIRMAN. All rights reserved.
//

import Foundation
import ObjectMapper

struct Media: Mappable {
    
    var type: String? //photo
    var sizes: Sizes?
    var mediaUrl: String?
    
    init?(map: Map) {
        
    }
    
    // Mappable
    mutating func mapping(map: Map) {
        self.type  <- map["type"]
        self.sizes <- map["sizes"]
        self.mediaUrl <- map["media_url_https"]
    }
}
