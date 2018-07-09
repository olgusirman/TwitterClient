//
//  TweetFetcher.swift
//  VNGRSTwitterClient
//
//  Created by Olgu Sırman on 9.07.2018.
//  Copyright © 2018 Olgu SIRMAN. All rights reserved.
//

import Foundation
import ObjectMapper

protocol TweetFetcher {
    
    //    func search( searchRouterObject: SearchRouterObject, successHandler : @escaping ( (_ tweets : [Tweet]?) -> Void ) , failure : @escaping failure)
    
    
    func search( searchRouterObject: SearchRouterObject, successHandler : @escaping ( (_ tweets : [Tweet]?) -> Void ))
}

struct MasterViewControllerTweetFetcher: TweetFetcher {
    
    private let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    //func search(searchRouterObject: SearchRouterObject, successHandler: @escaping (([Tweet]?) -> Void)) {
    func search(searchRouterObject: SearchRouterObject, completionHandler: @escaping ( ([Tweet]?) -> Void) ) {
            
        //networking.request(from: Router.search(searchRouterObject: searchRouterObject)) { (data, error) in }
        networking.request(urlRequest: Router.search(searchRouterObject: searchRouterObject)).responseJSON { (dataResponse) in
            ErrorManager.error(with: dataResponse)
            switch dataResponse.result {
            case .success:
                if let base = Mapper<BaseObject>().map(JSONObject: dataResponse.result.value) {
                    //successHandler(base.statuses)
                }
            case .failure(let error):
                print(error)
                ErrorManager.error(with: dataResponse)
                //failure(error)
            }
        }
        
    }
    
    /*
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
    }*/
    
}
