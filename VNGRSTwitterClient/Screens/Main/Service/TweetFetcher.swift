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
    associatedtype FetcherElement: Any
    typealias completionHandler = (FetcherElement?, _ dataResponse: DataResponse<Any>, Swift.Error?) -> Void
    func search( searchRouterObject: SearchRouterObject, completionHandler : @escaping completionHandler) //TODO: Generic bir router object
}

// TODO: later use generic fetcher protocol to use TweetFetcher struct
protocol TweetFetcher {
    typealias handler = ([Tweet]?, _ dataResponse: DataResponse<Any>, Swift.Error?) -> Void
    func search(searchRouterObject: SearchRouterObject, completionHandler : @escaping handler)
}

struct MasterViewControllerTweetFetcherViewModel: Fetcher {
        
    // MARK: Private Initializer property
    private let networking: AlamoNetworking
    
    // MARK: Initializer
    init(networking: AlamoNetworking) {
        self.networking = networking
    }
    
    func search(searchRouterObject: SearchRouterObject, completionHandler: @escaping TweetFetcher.handler) {
    
        networking.request(use: Router.search(searchRouterObject: searchRouterObject)).responseJSON { (dataResponse) in
            
            // Handle generic error
            ErrorManager.error(with: dataResponse)
            
            switch dataResponse.result {
            case .success:
                
                // If you use class, you can use Resolvable protocol also. But generally codable usage is OK, so that reason no need to Object Mapper a lot.
                if let object = Resolver.resolve(resolvedObject: BaseObject.self, dataResponse: dataResponse) {
                    completionHandler(object.statuses, dataResponse, nil)
                }
                
            case .failure(let error):
                completionHandler(nil, dataResponse, error)
            }
            
        }
    }
}

