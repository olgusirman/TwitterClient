//
//  UIFontExtension.swift
//  VNGRSTwitterClient
//
//  Created by Olgu on 6.06.2018.
//  Copyright © 2018 Olgu SIRMAN. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
    func sizeOfString (string: String, constrainedToWidth width: CGFloat) -> CGSize {
        return NSString(string: string).boundingRect(with: CGSize(width: width, height: .greatestFiniteMagnitude),
                                                     options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                     attributes: [NSAttributedStringKey.font: self],
                                                     context: nil).size
    }
}
