//
//  AuthObject.swift
//  VNGRSTwitterClient
//
//  Created by Olgu SIRMAN on 29.05.2018.
//  Copyright © 2018 Olgu SIRMAN. All rights reserved.
//

import Foundation

struct AuthObject: Codable {
    var accessToken: String?
    var tokenType: String?
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
    }
}
