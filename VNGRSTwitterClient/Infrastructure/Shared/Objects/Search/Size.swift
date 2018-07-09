//
//  Size.swift
//  VNGRSTwitterClient
//
//  Created by Olgu SIRMAN on 30.05.2018.
//  Copyright © 2018 Olgu SIRMAN. All rights reserved.
//

import Foundation
import ObjectMapper

struct Size: Mappable {
    
    var height: Int?
    var resize: SizeType?
    var width: Int?
    
    init?(map: Map) {
        
    }
    
    // Mappable
    mutating func mapping(map: Map) {
        self.height  <- map["h"]
        self.resize <- map["resize"]
        self.width <- map["w"]
    }
}
