//
//  BackendError.swift
//  VNGRSTwitterClient
//
//  Created by Olgu SIRMAN on 29.05.2018.
//  Copyright © 2018 Olgu SIRMAN. All rights reserved.
//

import Foundation

enum BackendError: Error {
    case network(error: Error)
    case dataSerialization(error: Error)
    case jsonSerialization(error: Error)
    case xmlSerialization(error: Error)
    case objectSerialization(reason: String)
}
