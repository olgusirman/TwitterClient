//
//  AppDelegate.swift
//  VNGRSTwitterClient
//
//  Created by Olgu SIRMAN on 18.05.2018.
//  Copyright © 2018 Olgu SIRMAN. All rights reserved.
//

import UIKit
import AlamofireNetworkActivityIndicator

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {
    
    // MARK: Properties
    var window: UIWindow?
    
    // MARK: Delegates
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        configureNetworkActivityIndicatorManager()
        checkTokenAndNavigateToMainIfNeeded()
        return true
    }
    
}

// MARK: - Configuration Helpers
extension AppDelegate {
    
    fileprivate func checkTokenAndNavigateToMainIfNeeded() {
        //Check token exist and valid, prepare for fetch tweets
        if (UserDefaults.standard.object(forKey: APIConstants.accessToken) != nil) {
            let rootController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
            window?.rootViewController = rootController;
            window?.makeKey()
        }
    }
    
    fileprivate func configureNetworkActivityIndicatorManager() {
        NetworkActivityIndicatorManager.shared.startDelay = 0.3
        NetworkActivityIndicatorManager.shared.completionDelay = 0.3
    }
    
}

