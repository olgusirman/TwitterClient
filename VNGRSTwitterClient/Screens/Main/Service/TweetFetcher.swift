//
//  TweetFetcher.swift
//  VNGRSTwitterClient
//
//  Created by Olgu Sırman on 9.07.2018.
//  Copyright © 2018 Olgu SIRMAN. All rights reserved.
//

import Foundation
import Alamofire

// Generic Fetcher protocol
protocol Fetcher {
    associatedtype T
    typealias completionHandler = (T?, _ dataResponse: DataResponse<Any>, Swift.Error?) -> Void
    func fetch( searchRouterObject: SearchRouterObject?, completionHandler : @escaping completionHandler) //TODO: Generic bir router object
}

// TODO: later use generic fetcher protocol to use TweetFetcher struct
protocol TweetFetcher {
    typealias handler = ([Tweet]?, _ dataResponse: DataResponse<Any>, Swift.Error?) -> Void
    func search( searchRouterObject: SearchRouterObject, completionHandler : @escaping handler)
}

// TODO: Create generic Fechter class,
// Bunu struct yaparsam resovler da self kullanamıyorum. Buna bir çözüm bulmak lazım
struct MasterViewControllerTweetFetcher: TweetFetcher {
    
    // MARK: Private Initializer property
    private let networking: AlamoNetworking
    
    // MARK: Initializer
    init(networking: AlamoNetworking) {
        self.networking = networking
    }
    
    func search(searchRouterObject: SearchRouterObject, completionHandler: @escaping handler ) {
        
        networking.request(use: Router.search(searchRouterObject: searchRouterObject)).responseJSON { (dataResponse) in
            
            // Handle generic error
            ErrorManager.error(with: dataResponse)
            
            switch dataResponse.result {
            case .success:
                
                // If you use class, you can use Resolvable protocol also. But generally codable usage is OK, so that reason no need to Object Mapper a lot.
                /*
                 if let resolved = Mapper<BaseObject>().map(JSONObject: dataResponse.result.value) {
                 completionHandler(resolved.statuses, dataResponse, nil)
                 } else {
                 let mappedError = NSError(domain: "Mapper not mapped", code: 0, userInfo: nil)
                 completionHandler(nil, dataResponse, mappedError)
                 }*/
                
                //if let object = self.resolve(resolvedObject: BaseObject.self, dataResponse: dataResponse) {
                //    completionHandler(object.statuses, dataResponse, nil)
                //}
                
                if let object = Resolver.resolve(resolvedObject: BaseObject.self, dataResponse: dataResponse) {
                    completionHandler(object.statuses, dataResponse, nil)
                }
                
            case .failure(let error):
                completionHandler(nil, dataResponse, error)
            }
            
        }
    }
}
