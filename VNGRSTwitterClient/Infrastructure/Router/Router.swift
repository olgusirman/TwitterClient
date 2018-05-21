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

protocol RestEndpoint : URLRequestConvertible {
    var method : HTTPMethod { get }
    var path : String { get }
    var encoding : Alamofire.ParameterEncoding { get }
    func asURLRequest() throws -> URLRequest
}

enum Router : RestEndpoint {
    
    case clientAdd
    case updateToken( token : String )
    case updateLocation ( coordinate : CLLocationCoordinate2D )
    case bloodDemandGetList( pageIndex : Int, pageSize : Int)
    case gsmConfirm(code : String)
    case gsmCreate(phone : String)
    
    var method : HTTPMethod {
        switch self {
        case .clientAdd, .gsmConfirm, .updateToken, .updateLocation:
            return .post
        case .gsmCreate,.bloodDemandGetList:
            return .get
        }
    }
    
    var path : String {
        switch self {
        case .clientAdd, .updateToken, .updateLocation:
            return "/client/add"
        case .bloodDemandGetList(let pageIndex,let pageSize):
            return "/blooddemand/getlist?clientId=\(APIManager().clientId!)&pageIndex=\(pageIndex)&pageSize=\(pageSize)"
        case .gsmConfirm:
            return "/confirmation/confirm"
        case .gsmCreate(let phone):
            debugPrint(phone)
            return "/confirmation/createcode"
        }
    }
    
    var encoding : ParameterEncoding {
        return JSONEncoding.default
    }
    
    func asURLRequest() throws -> URLRequest {
        
        let parameters : Parameters? = {
            switch self {
            case .clientAdd:
                let param : Parameters = ["":""]

                return param
            case .gsmConfirm(let code):
                let param : Parameters = ["clientId": APIManager().clientId ?? "" ,"code":code]
                return param
            case .updateToken( let token ):
                let param : Parameters = [ "id" : APIManager().clientId ?? "", "notificationToken" : token]
                return param
            case .updateLocation (let location):
                let param : Parameters = [ "id" : APIManager().clientId ?? "", "latitude" : location.latitude.magnitude, "longitude" : location.longitude.magnitude]
                return param
            default:
                return .none
            }
            
        }()
        
        let baseUrl = ""
        let url = try baseUrl.asURL()
        let requestUrl = try url.appendingPathComponent(path).asURL()
        var request = URLRequest(url: requestUrl)
        request.httpMethod = method.rawValue
        
        switch self {
        case .clientAdd,.gsmConfirm, .updateToken, .updateLocation:
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            return try encoding.encode(request, with: parameters)
        case .gsmCreate,.bloodDemandGetList:
            //request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            return try encoding.encode(request, with: nil)
        }
    }
    
}
