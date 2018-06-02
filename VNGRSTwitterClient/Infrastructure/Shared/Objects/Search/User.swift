//
//  User.swift
//  VNGRSTwitterClient
//
//  Created by Olgu on 2.06.2018.
//  Copyright © 2018 Olgu SIRMAN. All rights reserved.
//

import Foundation
import ObjectMapper

struct User: Mappable {
    
    var id: Int?
    var id_str: String?
    var name: String?
    var verified: Bool?
    var profileImageUrl: String?
    
    init?(map: Map) {
        
    }
    
    // Mappable
    mutating func mapping(map: Map) {
        self.id  <- map["id"]
        self.id_str <- map["id_str"]
        self.name <- map["text"]
        self.verified <- map["verified"]
        self.profileImageUrl <- map["profile_image_url_https"]
    }
}

extension User {
    
    func setImage(to imageView: UIImageView) {
        if let profileImageUrl = self.profileImageUrl {
            if let url = URL(string: profileImageUrl) {
                imageView.af_setImage(withURL: url)
            }
        }
    }
    
}
