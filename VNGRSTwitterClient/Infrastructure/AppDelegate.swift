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

        //Check token exist and valid, prepare for fetch tweets
        if (UserDefaults.standard.object(forKey: "access_token") != nil) {
            let rootController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
            window?.rootViewController = rootController;
            window?.makeKey()
        }
        
        return true
    }
    
    // MARK: - Split view
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        guard let topAsDetailController = secondaryAsNavController.topViewController as? DetailViewController else { return false }
        if topAsDetailController.detailTweet == nil {
            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
            return true
        }
        return false
    }
    
}

// MARK: - Configuration Helpers
extension AppDelegate {
    
    fileprivate func configureSplitViewController() {
        let splitViewController = window!.rootViewController as! UISplitViewController
        let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count-1] as! UINavigationController
        navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
        splitViewController.delegate = self
    }
    
    fileprivate func configureNetworkActivityIndicatorManager() {
        NetworkActivityIndicatorManager.shared.startDelay = 1.0
        NetworkActivityIndicatorManager.shared.completionDelay = 0.1
    }
    
}

