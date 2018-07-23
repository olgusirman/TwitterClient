//
//  SearchRouterObject.swift
//  VNGRSTwitterClient
//
//  Created by Olgu SIRMAN on 21.05.2018.
//  Copyright © 2018 Olgu SIRMAN. All rights reserved.
//

import Foundation

struct SearchRouterObject {
    var query: String
    var lang: String? = "tr"
    var resultType: SearchResultType? = .mixed
    var count: Int?
    var sinceId: Int?
    var maxId: Int?
    
    init?(query: String) {
        self.query = query
    }
}
