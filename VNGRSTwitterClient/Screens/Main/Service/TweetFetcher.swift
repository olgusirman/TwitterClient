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
protocol Fetcher: class {
    typealias completionHandler<FetcherElement> = (FetcherElement?, _ dataResponse: DataResponse<Any>, Swift.Error?) -> Void
    func fetch<FetcherElement>( convertible: URLRequestConvertible, completionHandler : @escaping completionHandler<FetcherElement>) //TODO: Generic bir router object
}

class FetcherModel: Fetcher {
   
    // MARK: Private Initializer property
    private let networking: AlamoNetworking
    
    // MARK: Initializer
    init(networking: AlamoNetworking) {
        self.networking = networking
    }
    
    func fetch<FetcherElement>(convertible: URLRequestConvertible, completionHandler : @escaping completionHandler<FetcherElement>) {

        networking.request(use:convertible).responseJSON { (dataResponse) in
            
            // Handle generic error
            ErrorManager.error(with: dataResponse)
            
            switch dataResponse.result {
            case .success:
                
                if let fetcher = dataResponse.value as? FetcherElement {
                    completionHandler(fetcher, dataResponse,nil)
                } else {
                    let userInfo = [NSLocalizedDescriptionKey: "dataResponse FetcherElement cast error"]
                    let fetcherCastError = NSError(domain: "", code: 409, userInfo: userInfo)
                    completionHandler(nil, dataResponse, fetcherCastError)
                }
                
                // If you use class, you can use Resolvable protocol also. But generally codable usage is OK, so that reason no need to Object Mapper a lot.
//                if let object = Resolver.resolve(resolvedObject: BaseObject.self, dataResponse: dataResponse) {
//                    completionHandler(object.statuses, dataResponse, nil)
//                }
                
            case .failure(let error):
                completionHandler(nil, dataResponse, error)
            }
            
        }
        
    }
    
}

// TODO: later use generic fetcher protocol to use TweetFetcher struct
protocol TweetFetcher {
    typealias handler = ([Tweet]?, _ dataResponse: DataResponse<Any>, Swift.Error?) -> Void
    func search(searchRouterObject: SearchRouterObject, completionHandler : @escaping handler)
}

struct MasterViewControllerTweetFetcherViewModel: TweetFetcher {
    
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

