//
//  AccessTokenAdapter.swift
//  VNGRSTwitterClient
//
//  Created by Olgu SIRMAN on 22.05.2018.
//  Copyright © 2018 Olgu SIRMAN. All rights reserved.
//

import Foundation
import Alamofire

final class AccessTokenAdapter: RequestAdapter {
    
    private let accessToken: String
    
    init(accessToken: String) {
        self.accessToken = accessToken
    }
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        // Create mutable clone
        var request = urlRequest
        request.setValue( "Bearer \(accessToken)", forHTTPHeaderField: APIConstants.authorization)
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: APIConstants.contentType)
        return request
    }
}
