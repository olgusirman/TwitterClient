//
//  Router.swift
//  HayatKurtar
//
//  Created by Olgu SIRMAN on 16/04/2017.
//  Copyright © 2017 Olgu Sirman. All rights reserved.
//

import Foundation
import Alamofire
import MapKit

protocol RestEndpoint: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var encoding: Alamofire.ParameterEncoding { get }
    func asURLRequest() throws -> URLRequest
}

enum Router: RestEndpoint {
    
    case authentication()
    case search(searchRouterObject: SearchRouterObject)
    
    var method : HTTPMethod {
        switch self {
        case .authentication:
            return .post
        case .search:
            return .get
        }
    }
    
    var path : String {
        switch self {
        case .authentication:
            return "/oauth2/token"
        case .search(_):
            return "/1.1/search/tweets.json"
        }
    }
    
    var encoding : ParameterEncoding {
        return URLEncoding.default
    }
    
    func asURLRequest() throws -> URLRequest {
        
        let parameters : Parameters? = {
            switch self {
            case .authentication:
                let parameter: Parameters = ["grant_type":"client_credentials"]
                return parameter
            case .search(let searchRouterObject):
                
                var param : Parameters = [:]
                let query = searchRouterObject.query
                // Required
                param["q"] = query
                
                // Optional
                if let sinceId = searchRouterObject.maxId {
                    param["max_id"] = sinceId
                }
                
                return param
            }
        }()
        
        let baseUrl = APIConstants.baseUrl
        let url = try baseUrl.asURL()
        let requestUrl = try url.appendingPathComponent(path).asURL()
        var request = URLRequest(url: requestUrl)
        request.httpMethod = method.rawValue
        
        switch self {
        case .authentication:
            
            let key = APIConstants.key
            let secret = APIConstants.secret
            let auth = "Basic " + (key + ":" + secret).base64()
            request.setValue( "\(auth)", forHTTPHeaderField: APIConstants.authorization)
            request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: APIConstants.contentType)
            
            return try encoding.encode(request, with: parameters)
        case .search(_):
            return try encoding.encode(request, with: parameters)
        }
    }
}


