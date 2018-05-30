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
    var sizes: Size?
    var media_url: String?
    
    init?(map: Map) {
        
    }
    
    // Mappable
    mutating func mapping(map: Map) {
        self.type  <- map["type"]
        self.sizes <- map["sizes"]
        self.media_url <- map["media_url"]
    }
}
