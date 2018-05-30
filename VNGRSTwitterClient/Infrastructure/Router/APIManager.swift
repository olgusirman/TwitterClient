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

final public class APIManager {
    
    // Handler typealiases
    typealias success = ( ( _ responseObject : Any) -> Void )
    typealias failure = ( ( _ error : Error? ) -> Void )
    
    // MARK: - Properties
    static let shared = APIManager() // TODO: Use dependency injection instead
    
    lazy var manager: Alamofire.SessionManager = {
        let manager = SessionManager.default
        if let authToken = UserDefaults.standard.string(forKey: "access_token") { // TODO: use KEYCHAIN for that "access_token"
            manager.adapter = AccessTokenAdapter(accessToken: authToken)
        }
        return manager
    }()
    
    // MARK: - Functions
    func authentication(successHandler : @escaping success , failure : @escaping failure) {
        
        Alamofire.request(Router.authentication()).validate().responseCodable { (response: DataResponse<AuthObject>) in
            
            switch response.result {
            case .success:
                
                // Serialize
                if let accessToken = response.value?.accessToken {
                    debugPrint("Successfully Authhenticate 👍")
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
        
        manager.request(Router.search(searchRouterObject: searchRouterObject)).validate().responseJSON { (dataResponse) in
            ErrorManager.error(with: dataResponse)
            switch dataResponse.result {
            case .success:
                print("Search Successful")
                
                if let base = Mapper<BaseObject>().map(JSONObject: dataResponse.result.value) {
                    successHandler(base.statuses)
                }
                
            case .failure(let error):
                print(error)
                failure(error)
            }
        }
    }
}



