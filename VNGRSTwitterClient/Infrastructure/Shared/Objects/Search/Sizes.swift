//
//  Sizes.swift
//  VNGRSTwitterClient
//
//  Created by Olgu on 3.06.2018.
//  Copyright © 2018 Olgu SIRMAN. All rights reserved.
//

import Foundation
import ObjectMapper

struct Sizes: Mappable {
    
    var thumb: Size?
    var large: Size?
    var medium: Size?
    var small: Size?
    
    init?(map: Map) {
        
    }
    
    // Mappable
    mutating func mapping(map: Map) {
        self.thumb  <- map["thumb"]
        self.large <- map["large"]
        self.medium <- map["medium"]
        self.small <- map["small"]
    }
}
