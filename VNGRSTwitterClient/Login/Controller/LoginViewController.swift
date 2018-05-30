//
//  LoginViewController.swift
//  VNGRSTwitterClient
//
//  Created by Olgu SIRMAN on 21.05.2018.
//  Copyright © 2018 Olgu SIRMAN. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {

    // MARK - Actions
    @IBAction func loginPressed(_ sender: UIButton) {
        
        APIManager.shared.authentication(successHandler: { (data) in
            
            let searchObject = SearchRouterObject(query: "istanbul")
            APIManager.shared.search(searchRouterObject: searchObject, successHandler: { (response) in
                debugPrint(response)
            }, failure: { error in
                debugPrint(error)
            })
            
        }) { (error) in
            
        }
    }
}
