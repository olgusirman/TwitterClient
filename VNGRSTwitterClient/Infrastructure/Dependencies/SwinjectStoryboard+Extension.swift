/// Copyright (c) 2018 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Foundation
import Swinject
import SwinjectStoryboard
import SwinjectAutoregistration

extension SwinjectStoryboard {
  @objc class func setup() {
    
    // Generic Networking part
    defaultContainer.autoregister(AlamoNetworking.self, initializer: HTTPNetworking.init)
    
    // Login
    //defaultContainer.autoregister(LoginFetcher.self, initializer: LoginTokenFetcher.init)
    ///
    
    SwinjectStoryboard.defaultContainer.storyboardInitCompleted(LoginViewController.self) { r, c in
        c.loginFetcher = r.resolve(LoginFetcher.self)
    }
    //SwinjectStoryboard.defaultContainer.register(LoginTokenFetcher.self) { _ in  }
    SwinjectStoryboard.defaultContainer.autoregister(LoginFetcher.self, initializer: LoginTokenFetcher.init)

    //let storyboard1 = SwinjectStoryboard.create(name: "Login", bundle: Bundle.main)
//    let navigationController = storyboard1.instantiateInitialViewController() as! UINavigationController
    //navigationController.performSegue(withIdentifier: "ToStoryboard2", sender: navigationController)
//    let loginViewController = navigationController.topViewController as! LoginViewController
    
    
    ///
//    let loginContainer = Container()
//    loginContainer.autoregister(LoginFetcher.self, initializer: LoginTokenFetcher.init)
    
    //let sb = SwinjectStoryboard.create(name: "Login", bundle: nil, container: loginContainer)
    //sb.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
    //loginContainer.storyboardInitCompleted(UINavigationController.self) { (resolver, controller) in
//        if let loginViewController = controller.topViewController as? LoginViewController {
//            loginViewController.loginFetcher = resolver ~> LoginTokenFetcher.self
//        }
//    }
    
    //loginContainer.storyboardInitCompleted(LoginViewController.self) { (resolver, controller) in}
    
    //defaultContainer.storyboardInitCompleted(LoginViewController.self) { resolver, controller in
        //controller.loginFetcher = resolver ~> LoginTokenFetcher.self
    //}
    
    // Master
    SwinjectStoryboard.defaultContainer.autoregister(TweetFetcher.self, initializer: MasterViewControllerTweetFetcher.init)
    SwinjectStoryboard.defaultContainer.storyboardInitCompleted(MasterViewController.self) { resolver, controller in
        //controller.fetcher = resolver ~> PriceFetcher.self
        controller.fetcher = resolver ~> TweetFetcher.self
    }
    
  }
}
