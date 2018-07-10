//
//  LoginViewController.swift
//  VNGRSTwitterClient
//
//  Created by Olgu SIRMAN on 21.05.2018.
//  Copyright © 2018 Olgu SIRMAN. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {
    
    @IBOutlet fileprivate weak var loginButton: UIButton!
    
    var loginFetcher: LoginFetcher?
    
    // MARK - Actions
    @IBAction func loginPressed(_ sender: UIButton) {
        loginButton.isEnabled = false
        login { [weak self] isSuccess, _, _ in
            guard isSuccess else { return }
            // after successfull login present the Main
            self?.presentMain()
        }
    }
    
    public func login(completionHandler: @escaping (_ isSuccess: Bool,_ token: String?, _ error: Error?) -> Void) {
        
        guard let fetcher = loginFetcher else { fatalError("Missing dependencies") }
        fetcher.authentication { (authToken, dataResponse, error) in
            
            if let error = error {
                self.loginButton.isEnabled = true
                completionHandler(false, nil, error)
                return
            }
            self.loginButton.isEnabled = true
            completionHandler(true, authToken, nil)
        }
    }
    
    private func presentMain() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let initialViewController = storyboard.instantiateInitialViewController() else { return } // TODO: use logger
        self.present(initialViewController, animated: true, completion: nil)
    }
    
}
