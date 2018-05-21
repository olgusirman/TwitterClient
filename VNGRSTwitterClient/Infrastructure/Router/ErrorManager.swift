//
//  ErrorManager.swift
//  HayatKurtar
//
//  Created by Olgu SIRMAN on 17/04/2017.
//  Copyright © 2017 Olgu Sirman. All rights reserved.
//

import Foundation
import Alamofire

class ErrorManager {
    
    class func error(with response : DataResponse<Any>) {
        
        guard case let .failure(error) = response.result else { return }
        
        if let error = error as? AFError {
            switch error {
            case .invalidURL(let url):
                print("AFError Invalid URL: \(url) - \(error.localizedDescription)")
            case .parameterEncodingFailed(let reason):
                print("AFError Parameter encoding failed: \(error.localizedDescription)")
                print("AFError Failure Reason: \(reason)")
            case .multipartEncodingFailed(let reason):
                print("AFError Multipart encoding failed: \(error.localizedDescription)")
                print("AFError Failure Reason: \(reason)")
            case .responseValidationFailed(let reason):
                print("AFError Response validation failed: \(error.localizedDescription)")
                print("AFError Failure Reason: \(reason)")
                
                switch reason {
                case .dataFileNil, .dataFileReadFailed:
                    print("AFError Downloaded file could not be read")
                case .missingContentType(let acceptableContentTypes):
                    print("AFError Content Type Missing: \(acceptableContentTypes)")
                case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
                    print("AFError Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)")
                case .unacceptableStatusCode(let code):
                    print("AFError Response status code was unacceptable: \(code)")
                }
            case .responseSerializationFailed(let reason):
                print("AFError Response serialization failed: \(error.localizedDescription)")
                print("AFError Failure Reason: \(reason)")
            }
            
            print("AFError Underlying error: \(String(describing: error.underlyingError))")
        } else if let error = error as? URLError {
            print("AFError URLError occurred: \(error)")
        } else {
            print("AFError Unknown error: \(error)")
        }
        
        
    }
    
}
