//
//  VNGRSLoginTests.swift
//  VNGRSTwitterClientTests
//
//  Created by Olgu on 4.06.2018.
//  Copyright © 2018 Olgu SIRMAN. All rights reserved.
//

import XCTest
@testable import VNGRSTwitterClient

final class VNGRSLoginTests: VNGRSRootTests {
    
    // MARK - Properties
    var loginViewController: LoginViewController!
    
    // MARK: - Lifecycle
    override func setUp() {
        super.setUp()
        prepareController()
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
    
    // MARK: - Tests

    func testLoginIsSuccesfull() {
        
        // given
        let expectation = self.expectation(description: "Expected load auth from tweet to fail")
        
        // when
        loginViewController.login { isSuccess, token in
            XCTAssert(isSuccess, "Login is successfull, auth token ")
            XCTAssertNotNil(token, "There is a bearer auth token")
            expectation.fulfill()
        }
        
        // then
        waitForExpectations(timeout: 3, handler: nil)
    }
    
}
