//
//  TweetCellDelegate.swift
//  VNGRSTwitterClient
//
//  Created by Olgu on 6.06.2018.
//  Copyright © 2018 Olgu SIRMAN. All rights reserved.
//

import UIKit

protocol TweetCellDelegate: class {
    func imageLoaded(with image: UIImage?, with indexPath: IndexPath?)
}
