//
//  VNGRSMainTests.swift
//  VNGRSTwitterClientTests
//
//  Created by Olgu on 4.06.2018.
//  Copyright © 2018 Olgu SIRMAN. All rights reserved.
//

import XCTest
@testable import VNGRSTwitterClient

final class VNGRSMainTests: XCTestCase {
    
    // MARK - Properties
    var masterViewController: MasterViewController!
    
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
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let splitViewController = storyboard.instantiateInitialViewController() as! UISplitViewController
        let navigationController = splitViewController.viewControllers.first as! UINavigationController
        self.masterViewController = navigationController.viewControllers.first as! MasterViewController
        _ = masterViewController.view // To call viewDidLoad
    }
    
    // MARK: - Tests
    
    func testLoginIsSuccesfull() {
        
        // given
        let expectation = self.expectation(description: "Expected load tweets from api fail")
        
        // when
        masterViewController.fetchTweets(searchText: "wwdc2018") { (isSuccess, tweets) in
            XCTAssert(isSuccess, "Tweets fetched is successfull")
            XCTAssertNotNil(tweets, "There should be a tweets")
            //XCTAssertGreaterThanOrEqual(tweets!.count, 0, "Tweets should be not nil and must have tweets")
            expectation.fulfill()
        }
        
        // then
        waitForExpectations(timeout: 3, handler: nil)
    }
    
}
