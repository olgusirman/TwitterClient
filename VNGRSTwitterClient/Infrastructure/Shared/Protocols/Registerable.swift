//
//  Registerable.swift
//  VNGRSTwitterClient
//
//  Created by Olgu Sırman on 24.07.2018.
//  Copyright © 2018 Olgu SIRMAN. All rights reserved.
//

import Foundation
import Swinject

protocol Registerable {
    static func register(container: Container)
}
