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
    case search(searchRouterObject: SearchRouterObject?)
    
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
            return "/oauth2/token" //https://api.twitter.com/oauth2/token
        case .search(_):
            return "/1.1/search/tweets.json" //1.1 calisti ama emin degilim 2.0 i da deneyebilirsin yada silerek deneyebilirsin //https://api.twitter.com/1.1/search/tweets.json
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
                if let query = searchRouterObject?.query {
                    param["q"] = query
                }
                //param["count"] = 20
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
            
            let key = "NMrMAQcp7YhN2WMNAJYrGdCa6"
            let secret = "N2Qf4gckLSaV7R3lwyCdb0Hb2plV2TqbFvHIeWAp4Yo9WjJegx"
            
            let auth = "Basic " + (key + ":" + secret).base64()
            
            request.setValue( "\(auth)", forHTTPHeaderField: "Authorization")
            request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
            
            return try encoding.encode(request, with: parameters)
            
        case .search(_):
            
            //let defaults = UserDefaults.standard
            //let accessToken = defaults.object(forKey: "access_token") as! String //TODO: get access_token from keychain
            
            //request.setValue( "Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            //request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
            
            return try encoding.encode(request, with: parameters)
        }
    }
}

extension String {
    
    func base64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}
