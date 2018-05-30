//
//  BaseObject.swift
//  VNGRSTwitterClient
//
//  Created by Olgu SIRMAN on 31.05.2018.
//  Copyright © 2018 Olgu SIRMAN. All rights reserved.
//

import Foundation
import ObjectMapper

struct BaseObject: Mappable {
    
    var statuses: [Tweet]?
    
    init?(map: Map) {
        
    }
    
    // Mappable
    mutating func mapping(map: Map) {
        self.statuses  <- map["statuses"]
    }
    
}
