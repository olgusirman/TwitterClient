//
//  MasterAssembly.swift
//  VNGRSTwitterClient
//
//  Created by Olgu Sırman on 24.07.2018.
//  Copyright © 2018 Olgu SIRMAN. All rights reserved.
//

import Foundation
import Swinject
import SwinjectAutoregistration
import SwinjectStoryboard

struct MasterAssembly: Registerable {
    
    static func register(container: Container) {
        container.autoregister(TweetFetcher.self, initializer: MasterViewControllerTweetFetcherViewModel.init)
        container.storyboardInitCompleted(MasterViewController.self) { resolver, controller in
            controller.fetcher = resolver ~> TweetFetcher.self //same as controller.fetcher = resolver.resolve(TweetFetcher.self)
        }
    }
    
}
