//
//  LoginAssembly.swift
//  VNGRSTwitterClient
//
//  Created by Olgu Sırman on 24.07.2018.
//  Copyright © 2018 Olgu SIRMAN. All rights reserved.
//

import Foundation
import Swinject
import SwinjectAutoregistration
import SwinjectStoryboard

struct LoginAssembly: Registerable {
    
    static func register(container: Container) {
        // LoginViewController
        container.storyboardInitCompleted(LoginViewController.self) { resolver, controller in
            controller.loginFetcher = resolver ~> LoginFetcher.self
        }
        // Login Fetcher
        container.autoregister(LoginFetcher.self, initializer: LoginTokenFetcher.init)
    }
    
}
