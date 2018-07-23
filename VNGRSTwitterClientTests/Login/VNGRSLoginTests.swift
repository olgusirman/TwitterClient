//
//  VNGRSLoginTests.swift
//  VNGRSTwitterClientTests
//
//  Created by Olgu on 4.06.2018.
//  Copyright © 2018 Olgu SIRMAN. All rights reserved.
//

import XCTest
import Swinject
import SwinjectAutoregistration

@testable import VNGRSTwitterClient

final class VNGRSLoginTests: XCTestCase {
    
    // MARK - Properties
    private var loginViewController: LoginViewController!
    private let container = Container()
    
    // MARK: - Lifecycle
    override func setUp() {
        super.setUp()
        prepareController()
        configureRegisteration()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - Helpers
    // Prepare Helper
    private func prepareController() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        self.loginViewController = navigationController.viewControllers.first as! LoginViewController
        _ = loginViewController.view // To call viewDidLoad
        
    }
    
    func configureRegisteration() {
        
        container.autoregister(AlamoNetworking.self, initializer: HTTPNetworking.init)
        
        // LoginViewController
        container.storyboardInitCompleted(LoginViewController.self) { resolver, controller in
            //c.loginFetcher = r.resolve(LoginFetcher.self)
            controller.loginFetcher = resolver ~> LoginFetcher.self
        }
        // Login Fetcher
        container.autoregister(LoginFetcher.self, initializer: LoginTokenFetcher.init)
        
    }
    
    // MARK: - Registrations
    
    private func testLoginFectherRegistration() {
        XCTAssertNotNil(container.resolve(LoginFetcher.self), "Injection handled in LoginViewController")
    }
    
    // MARK: - Login Tests
    
    func testLoginIsSuccesfull() {
        
        // given
        let expectation = self.expectation(description: "Expected load auth from tweet to fail")
        
        // when
        loginViewController.login { isSuccess, token, error  in
            XCTAssert(isSuccess, "Login is successfull, auth token \(String(describing: error?.localizedDescription))")
            XCTAssertNotNil(token, "There is a bearer auth token")
            expectation.fulfill()
        }
        
        // then
        waitForExpectations(timeout: 3, handler: nil)
    }
    
}
