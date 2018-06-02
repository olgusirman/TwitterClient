//
//  Roundable.swift
//  VNGRSTwitterClient
//
//  Created by Olgu on 2.06.2018.
//  Copyright © 2018 Olgu SIRMAN. All rights reserved.
//

import UIKit

protocol Roundable {
    func roundCorners()
}

extension Roundable where Self: UIView {
    func roundCorners() {
        layer.cornerRadius = self.bounds.size.width / 2
        layer.masksToBounds = true
    }
}
