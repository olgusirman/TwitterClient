//
//  SearchResultType.swift
//  VNGRSTwitterClient
//
//  Created by Olgu on 3.06.2018.
//  Copyright © 2018 Olgu SIRMAN. All rights reserved.
//

import Foundation

enum SearchResultType: String {
    case mixed
    case recent
    case popular
}

//* mixed : Include both popular and real time results in the response.
//* recent : return only the most recent results in the response
//* popular : return only the most popular results in the response.
