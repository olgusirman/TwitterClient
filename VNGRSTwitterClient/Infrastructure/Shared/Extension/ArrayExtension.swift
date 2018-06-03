//
//  ArrayExtension.swift
//  VNGRSTwitterClient
//
//  Created by Olgu on 2.06.2018.
//  Copyright © 2018 Olgu SIRMAN. All rights reserved.
//

import Foundation
import RxSwift

extension Array where Element: Tweet {
    
    func search(query: Event<String>) -> [Element] {
        
        if let element = query.element, element.isEmpty {
             return self
        } else {
            return self.filter({
                guard let text = $0.text, let queryElement = query.element else { return false }
                return text.search(queryElement)
            })
        }
    }
    
}
