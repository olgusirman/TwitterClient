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
            
            // after successfull login present the Main
            self.presentMain()
            
        }) { (error) in
            
        }
    }
    
    private func presentMain() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let initialViewController = storyboard.instantiateInitialViewController() else { return } // TODO: use logger
        self.present(initialViewController, animated: true, completion: nil)
        
    }
    
}
