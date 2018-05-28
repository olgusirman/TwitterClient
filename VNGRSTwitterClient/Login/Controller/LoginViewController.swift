//
//  LoginViewController.swift
//  VNGRSTwitterClient
//
//  Created by Olgu SIRMAN on 21.05.2018.
//  Copyright © 2018 Olgu SIRMAN. All rights reserved.
//

import UIKit
import TwitterKit

final class LoginViewController: UIViewController {

    // MARK: Properties
    
    @IBOutlet fileprivate weak var loginButton: TWTRLogInButton!
    
    // MARK - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //logInCompletion()
    }
    
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
    
    private func logInCompletion() {
        
        /*
        loginButton.logInCompletion = { session, error in
            debugPrint(error)
            debugPrint(session?.authToken) //721667833575448576-AT2HELhLH9TeqYsJZZc9alQpF9NkcZR
            debugPrint(session?.authTokenSecret) //zS8J1hy35BruD9lvXssjah6caZCTMg95tO0jlDAZVQ1yF
            
            if let authToken = session?.authToken, let authTokenSecret = session?.authTokenSecret  {
                
                let defaults = UserDefaults.standard
                defaults.set(authToken, forKey: "authToken")
                defaults.set(authTokenSecret, forKey: "authTokenSecret")
                defaults.synchronize()
                
                
            }
            
        }*/
    }
    
}
