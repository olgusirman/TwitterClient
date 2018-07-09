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

protocol Networking {
    //typealias CompletionHandler = (Data?, Swift.Error?) -> Void
    //typealias CompletionHandler = (DataResponse<Any>) -> Void
    
    typealias success = ( ( _ responseObject : Any) -> Void )
    typealias failure = ( ( _ error : Error? ) -> Void )
    //func request( from:RestEndpoint, completion: @escaping CompletionHandler) -> DataRequest
    func request(urlRequest: URLRequestConvertible) -> DataRequest
}

//protocol Resolver {
//    associatedtype T: Decodable
//    func resolve<T: Decodable>()
//}

final public class HTTPNetworking: Networking {
    
    // MARK: - Properties
    
    // MARK: Private Properties
    fileprivate var manager: Alamofire.SessionManager = {
        let manager = SessionManager.default
        if let authToken = UserDefaults.standard.string(forKey: APIConstants.accessToken) { // Use keychain for that "access_token"
            manager.adapter = AccessTokenAdapter(accessToken: authToken)
        }
        return manager
    }()
    
    func request(urlRequest: URLRequestConvertible) -> DataRequest {
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

// Helper
extension Networking {
    
    //private func createDataRequest(urlRequest: URLRequestConvertible) -> DataRequest {
    //    return manager.request(urlRequest)
    //}
    
    private func resolve<T: BaseMappable>( resolvedObject: T.Type,
                                           dataResponse: DataResponse<Any>) -> T? {
        
        // Resolve mapped object
        if let resolved = Mapper<T>().map(JSONObject: dataResponse.result.value) {
            return resolved
        } else {
            debugPrint("\(T.self) item not resolved in \(#function)")
            return nil
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from,
            let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
    
}
