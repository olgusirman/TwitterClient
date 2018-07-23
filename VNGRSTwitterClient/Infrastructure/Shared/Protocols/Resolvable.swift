//
//  Resolvable.swift
//  VNGRSTwitterClient
//
//  Created by Olgu Sırman on 23.07.2018.
//  Copyright © 2018 Olgu SIRMAN. All rights reserved.
//

import ObjectMapper
import Alamofire

protocol Resolvable {
    static func resolve<T: BaseMappable>( resolvedObject: T.Type,
                                   dataResponse: DataResponse<Any>) -> T?
    static func resolve<T: Decodable>(type: T.Type, from: Data?) -> T?
}

extension Resolvable {
    
    static func resolve<T: BaseMappable>( resolvedObject: T.Type,
                                   dataResponse: DataResponse<Any>) -> T? {
        
        // Resolve mapped object
        if let resolved = Mapper<T>().map(JSONObject: dataResponse.result.value) {
            return resolved
        } else {
            debugPrint("\(T.self) item not resolved in \(#function)")
            return nil
        }
    }
    
    static func resolve<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from,
            let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
    
}
