//
//  TweetFetcher.swift
//  VNGRSTwitterClient
//
//  Created by Olgu Sırman on 9.07.2018.
//  Copyright © 2018 Olgu SIRMAN. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

// Generic Fetcher protocol
protocol Fetcher: Resolvable {
    associatedtype T
    typealias completionHandler = (T?, _ dataResponse: DataResponse<Any>, Swift.Error?) -> Void
    func fetch( searchRouterObject: SearchRouterObject?, completionHandler : @escaping completionHandler) //TODO: Generic bir router object
}

protocol Resolvable {
    func resolve<T: BaseMappable>( resolvedObject: T.Type,
                                   dataResponse: DataResponse<Any>) -> T?
    func resolve<T: Decodable>(type: T.Type, from: Data?) -> T?
}

extension Resolvable {
    
    func resolve<T: BaseMappable>( resolvedObject: T.Type,
                                           dataResponse: DataResponse<Any>) -> T? {
        
        // Resolve mapped object
        if let resolved = Mapper<T>().map(JSONObject: dataResponse.result.value) {
            return resolved
        } else {
            debugPrint("\(T.self) item not resolved in \(#function)")
            return nil
        }
    }
    
    func resolve<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from,
            let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
    
}

// TODO: later use generic fetcher protocol to use TweetFetcher struct
protocol TweetFetcher: Resolvable {
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
        
        networking.request(use: Router.search(searchRouterObject: searchRouterObject)).responseJSON { [self] (dataResponse) in
            
            // Handle generic error
            ErrorManager.error(with: dataResponse)
            
            switch dataResponse.result {
            case .success:
                
                if let object = self.resolve(resolvedObject: BaseObject.self, dataResponse: dataResponse) {
                    completionHandler(object.statuses, dataResponse, nil)
                }
                
                //if let base = Mapper<BaseObject>().map(JSONObject: dataResponse.result.value) {
                //    completionHandler(base.statuses, dataResponse, nil)
                //}
                
            case .failure(let error):
                completionHandler(nil, dataResponse, error)
            }
            
        }
    }
}
