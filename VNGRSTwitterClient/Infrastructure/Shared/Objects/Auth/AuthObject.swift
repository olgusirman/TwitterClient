//
//  AuthObject.swift
//  VNGRSTwitterClient
//
//  Created by Olgu SIRMAN on 29.05.2018.
//  Copyright © 2018 Olgu SIRMAN. All rights reserved.
//

import Foundation

struct AuthObject: Codable {
    
    // MARK: Properties
    var accessToken: String?
    var tokenType: String?
    
}

extension AuthObject {
    
    // MARK: CodingKeys
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
    }
    
    // MARK: Encodable
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(accessToken, forKey: .accessToken)
        try container.encode(tokenType, forKey: .tokenType)
    }
    
    // MARK: Decodable
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accessToken = try values.decode(String.self, forKey: .accessToken)
        tokenType = try values.decode(String.self, forKey: .tokenType)
    }
    
}
