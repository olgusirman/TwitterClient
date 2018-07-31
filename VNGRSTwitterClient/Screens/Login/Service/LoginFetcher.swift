//
//  LoginFetcher.swift
//  VNGRSTwitterClient
//
//  Created by Olgu Sırman on 10.07.2018.
//  Copyright © 2018 Olgu SIRMAN. All rights reserved.
//

import Foundation
import Alamofire

protocol LoginFetcher {
    typealias handler = (_ accessToken: String?, Swift.Error?) -> Void
    func authentication( completionHandler : @escaping handler)
}

struct LoginTokenFetcher: LoginFetcher {
    
    // MARK: Private Initializer property
    private let networking: AlamoNetworking
    
    // MARK: Initializer
    init(networking: AlamoNetworking) {
        self.networking = networking
    }
    
    func authentication( completionHandler: @escaping handler) {
        
        networking.request(use: Router.authentication()).validate().responseCodable { (dataResponse: DataResponse<AuthObject>) in
            
            // Handle generic error
            // TODO: cast problem DataResponse<AuthObject> to DataResponse<Any>
            //ErrorManager.error(with: dataResponse)
            
            switch dataResponse.result {
            case .success:
                
                if let accessToken = dataResponse.value?.accessToken {
                    debugPrint("Successfully Authhenticate 👍")
                    UserDefaults.standard.set(accessToken, forKey: APIConstants.accessToken)
                    //successHandler(accessToken)
                    completionHandler(accessToken, nil)
                    
                } else {
                    //not Mapped
                }
                //if let base = Mapper<BaseObject>().map(JSONObject: dataResponse.result.value) {
                //    completionHandler(base.statuses, dataResponse, nil)
                //}
                
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
    
}
