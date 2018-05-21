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

        loginButton.logInCompletion = { session,error in
            debugPrint(error)
            debugPrint(session?.authToken) //721667833575448576-AT2HELhLH9TeqYsJZZc9alQpF9NkcZR
            debugPrint(session?.authTokenSecret) //zS8J1hy35BruD9lvXssjah6caZCTMg95tO0jlDAZVQ1yF
        }
    }
    
    // MARK: - Memory Management
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
