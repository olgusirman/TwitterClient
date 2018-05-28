//
//  APIManager.swift
//  HayatKurtar
//
//  Created by Olgu SIRMAN on 17/04/2017.
//  Copyright © 2017 Olgu Sirman. All rights reserved.
//

import Foundation
import Alamofire
import TwitterKit

final public class APIManager {
    
    typealias success = ( ( _ responseObject : Any) -> Void )
    typealias failure = ( ( _ error : Error? ) -> Void )
    
    static let shared = APIManager()
    
    lazy var manager: Alamofire.SessionManager = {
        let manager = SessionManager.default
        if let authToken = UserDefaults.standard.string(forKey: "access_token") { // TODO: use that access_token KEYCHAIN
            manager.adapter = AccessTokenAdapter(accessToken: authToken)
        }
        return manager
    }()
    
    func authentication(successHandler : @escaping success , failure : @escaping failure) {
        
        Alamofire.request(Router.authentication()).responseJSON { (dataResponse) in
            
            switch dataResponse.result {
            case .success:
                print("Token validation successful")
                debugPrint(dataResponse.result.value)
                
                // Serialize
                if let valueDict = dataResponse.result.value as? [String:String] {
                    if let accessToken = valueDict["access_token"] {
                        let defaults = UserDefaults.standard
                        defaults.set(accessToken, forKey: "access_token")
                        defaults.synchronize()
                        debugPrint("Successfully Authhenticate 👍")
                        successHandler(accessToken)
                    }
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func search( searchRouterObject: SearchRouterObject, successHandler : @escaping success , failure : @escaping failure) {
        
        manager.request(Router.search(searchRouterObject: searchRouterObject)).responseJSON { (dataResponse) in
            
            switch dataResponse.result {
            case .success:
                print("Search Successful")
                debugPrint(dataResponse.result.value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}



