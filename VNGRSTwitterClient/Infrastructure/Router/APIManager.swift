//
//  APIManager.swift
//  HayatKurtar
//
//  Created by Olgu SIRMAN on 17/04/2017.
//  Copyright © 2017 Olgu Sirman. All rights reserved.
//

import Foundation
import Alamofire

final class APIManager {
    
    typealias success = ( ( _ responseObject : Any) -> Void )
    typealias failure = ( ( _ error : Error?, _ message : String? ) -> Void )
    
    var clientId : String? = ""
    
    //MARK: Initial ClientId
    /*
    func getClientId(completion : ( () -> Void )? = nil ) {
        
        Alamofire.request(Router.clientAdd).responseJSON { (dataResponse) in
            switch dataResponse.result {
            case .success:
                if let json = dataResponse.result.value {
                    if let responseBase = Mapper<ResponseBase>().map(JSONObject: json) {
                        guard let isOk = responseBase.isOk else { return }
                        if isOk {
                            
                            if self.clientId == nil {
                                self.clientId = responseBase.data?.id
                                completion?()
                            }
                        } else {
                            debugPrint("Error occured, Message :\(String(describing: responseBase.message))")
                        }
                    }
                }
                
            case .failure(let error):
                print(error)
                ErrorManager.error(with: dataResponse)
            }
        }
    }
    
    //MARK: SMS
    
    func requestCode(with phone : String, successHandler : @escaping success , failure : @escaping failure ) {
        
        let url = "\(HKConstants.baseUrl)/confirmation/createcode?clientId=\(APIManager().clientId!)&phone=%2B\(phone)"
        //TODO: add parameter but phone number is not a valid error occured, what should be done?
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (dataResponse) in
            
            switch dataResponse.result {
            case .success:
                if let json = dataResponse.result.value {
                    if let responseBase = Mapper<ResponseBase>().map(JSONObject: json) {
                        
                        guard let isOk = responseBase.isOk else { return }
                        if isOk {
                            successHandler(responseBase)
                        } else {
                            debugPrint("Error occured, Message :\(String(describing: responseBase.message))")
                            let error = NSError(domain: "isOkError", code: 0, userInfo: [NSLocalizedDescriptionKey:"Bir hata oluştu"])
                            failure(error, String(describing: responseBase.message) )
                        }
                    }
                }
            case .failure(let error):
                failure(error, error.localizedDescription)
                print(error)
                ErrorManager.error(with: dataResponse)
            }
        }
    }
    
    func sendCode(with code : String, successHandler : @escaping success , failure : @escaping failure) {
        
        Alamofire.request(Router.gsmConfirm(code: code)).responseJSON { (dataResponse) in
            
            switch dataResponse.result {
            case .success:
                
                if let json = dataResponse.result.value {
                    print("JSON: \(json)")
                    if let responseBase = Mapper<ResponseBase>().map(JSONObject: json) {
                        guard let isOk = responseBase.isOk else { return }
                        if isOk {
                            successHandler(responseBase)
                        } else {
                            debugPrint("Error occured, Message :\(String(describing: responseBase.message))")
                            let error = NSError(domain: "isOkError", code: 0, userInfo: [NSLocalizedDescriptionKey:"Kod yollanırken bir hata oluştu."])
                            failure(error, String(describing: responseBase.message) )
                        }
                    }
                }
            case .failure(let error):
                failure(error, error.localizedDescription)
                ErrorManager.error(with: dataResponse)
            }
        }
    }
    
    //MARK: Send Demand
    func postBloodDemand(with donorSeeker : DonorSeeker, successHandler : @escaping success , failure : @escaping failure) {
        
        Alamofire.request(Router.bloodDemand(donorSeeker: donorSeeker)).responseJSON { (dataResponse) in
            switch dataResponse.result {
            case .success:
                
                if let json = dataResponse.result.value {
                    if let responseBase = Mapper<ResponseBase>().map(JSONObject: json) {
                        guard let isOk = responseBase.isOk else { return }
                        if isOk {
                            successHandler(responseBase)
                        } else {
                            debugPrint("Error occured, Message :\(String(describing: responseBase.message))")
                            
                            let error = NSError(domain: "isOkError", code: 0, userInfo: [NSLocalizedDescriptionKey:"Kan isteğiniz yollanırken bir hata oluştu."])
                            failure(error, String(describing: responseBase.message) )
                        }
                    }
                }
            case .failure(let error):
                failure(error, error.localizedDescription)
                print(error)
                ErrorManager.error(with: dataResponse)
            }
        }
    }
    
    func getSeekers(pageIndex : Int, pageSize : Int,successHandler : @escaping success , failure : @escaping failure) {
        
        let url = "\(HKConstants.baseUrl)/blooddemand/getlist?clientId=\(APIManager().clientId!)&pageIndex=\(pageIndex)&pageSize=\(pageSize)"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (dataResponse) in
            
            switch dataResponse.result {
            case .success:
                
                if let json = dataResponse.result.value {
                    if let responseBase = Mapper<ResponseBase>().map(JSONObject: json) {
                        
                        guard let isOk = responseBase.isOk else { return }
                        
                        if isOk {
                            successHandler(responseBase)
                        } else {
                            debugPrint("Error occured, Message :\(String(describing: responseBase.message))")
                            let error = NSError(domain: "isOkError", code: 0, userInfo: [NSLocalizedDescriptionKey:"Kan isteğiniz yollanırken bir hata oluştu."])
                            failure(error, String(describing: responseBase.message) )
                        }
                    }
                }
                
            case .failure(let error):
                failure(error, error.localizedDescription)
                print(error)
                ErrorManager.error(with: dataResponse)
            }
        }
    }
    */
    
}

