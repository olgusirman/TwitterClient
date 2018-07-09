//
//  ResponseObjectSerializable.swift
//  VNGRSTwitterClient
//
//  Created by Olgu SIRMAN on 29.05.2018.
//  Copyright © 2018 Olgu SIRMAN. All rights reserved.
//

import Foundation

protocol ResponseObjectSerializable {
    init?(representation: Any)
}
