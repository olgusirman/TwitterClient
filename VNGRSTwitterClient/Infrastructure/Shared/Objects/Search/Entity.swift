//
//  Entity.swift
//  VNGRSTwitterClient
//
//  Created by Olgu SIRMAN on 30.05.2018.
//  Copyright © 2018 Olgu SIRMAN. All rights reserved.
//

import Foundation
import ObjectMapper

struct Entity: Mappable {
    
    var media: [Media]?
    
    init?(map: Map) {
        
    }
    
    // Mappable
    mutating func mapping(map: Map) {
        self.media  <- map["media"]
    }
}


