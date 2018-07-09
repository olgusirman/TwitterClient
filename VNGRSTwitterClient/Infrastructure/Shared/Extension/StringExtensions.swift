//
//  StringExtensions.swift
//  VNGRSTwitterClient
//
//  Created by Olgu on 2.06.2018.
//  Copyright © 2018 Olgu SIRMAN. All rights reserved.
//

import Foundation

extension String {
    
    func search(_ term: String) -> Bool {
        let lowercasedSelf = self.lowercased()
        let lowercasedTerm = term.lowercased()
        return lowercasedSelf.localizedCaseInsensitiveContains(lowercasedTerm)
    }
    
    func base64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}
