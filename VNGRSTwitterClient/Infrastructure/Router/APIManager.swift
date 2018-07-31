//
//  APIManager.swift
//  HayatKurtar
//
//  Created by Olgu SIRMAN on 17/04/2017.
//  Copyright © 2017 Olgu Sirman. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

protocol AlamoNetworking {
    var manager: SessionManager { get }
    func request(use urlRequest: URLRequestConvertible) -> DataRequest
}

//protocol Networking {
    //typealias CompletionHandler = (Data?, Swift.Error?) -> Void
    //func request(from: Endpoint, completion: @escaping CompletionHandler)
//}


final public class HTTPNetworking: AlamoNetworking {
    
    // MARK: - Properties
    
    // MARK: Private Properties
    var manager: Alamofire.SessionManager = {
        let manager = SessionManager.default
        if let authToken = UserDefaults.standard.string(forKey: APIConstants.accessToken) { // Use keychain for that "access_token"
            manager.adapter = AccessTokenAdapter(accessToken: authToken)
        }
        return manager
    }()
    
    func request(use urlRequest: URLRequestConvertible) -> DataRequest {
        return manager.request(urlRequest)
    }
    
    // MARK: - Functions
    /*
    func authentication(successHandler : @escaping success , failure : @escaping failure) {
        
        Alamofire.request(Router.authentication()).validate().responseCodable { (response: DataResponse<AuthObject>) in
            switch response.result {
            case .success:
                // Serialize
                if let accessToken = response.value?.accessToken {
                    debugPrint("Successfully Authhenticate 👍")
                    UserDefaults.standard.set(accessToken, forKey: APIConstants.accessToken)
                    successHandler(accessToken)
                } else {
                    //not Mapped
                }
            case .failure(let error):
                print(error)
                failure(error)
            }
        }
    }
 
    func search( searchRouterObject: SearchRouterObject, successHandler : @escaping ( (_ tweets : [Tweet]?) -> Void ) , failure : @escaping failure) {
        
        manager.request(Router.search(searchRouterObject: searchRouterObject)).responseJSON { (dataResponse) in
            ErrorManager.error(with: dataResponse)
            switch dataResponse.result {
            case .success:
                if let base = Mapper<BaseObject>().map(JSONObject: dataResponse.result.value) {
                    successHandler(base.statuses)
                }
            case .failure(let error):
                print(error)
                ErrorManager.error(with: dataResponse)
                failure(error)
            }
        }
    }
 */
    
}
