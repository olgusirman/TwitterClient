//
//  VNGRSMainTests.swift
//  VNGRSTwitterClientTests
//
//  Created by Olgu on 4.06.2018.
//  Copyright © 2018 Olgu SIRMAN. All rights reserved.
//

import XCTest
import Swinject
import SwinjectAutoregistration
import SwinjectStoryboard

@testable import VNGRSTwitterClient

final class VNGRSMainTests: XCTestCase {
    
    // MARK - Properties
    var masterViewController: MasterViewController!
    private let container = Container()
    
    // MARK: - Lifecycle
    override func setUp() {
        super.setUp()
        prepareController()
        configureRegisteration()
    }
    
    override func tearDown() {
        container.removeAll()
        super.tearDown()
    }
    
    // MARK: - Helpers
    // Prepare Helper
    private func prepareController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let splitViewController = storyboard.instantiateInitialViewController() as! UISplitViewController
        let navigationController = splitViewController.viewControllers.first as! UINavigationController
        self.masterViewController = navigationController.viewControllers.first as! MasterViewController
        //_ = masterViewController.view // To call viewDidLoad // her türlü viewDidLoad çağırılıyor.
    }
    
    func configureRegisteration() {
        
        /*
         container.autoregister(AlamoNetworking.self, initializer: HTTPNetworking.init)
         
         // Master
         SwinjectStoryboard.defaultContainer.autoregister(TweetFetcher.self, initializer: MasterViewControllerTweetFetcher.init)
         SwinjectStoryboard.defaultContainer.storyboardInitCompleted(MasterViewController.self) { resolver, controller in
         controller.fetcher = resolver ~> TweetFetcher.self
         }*/
        
        NetworkingAssembly.register(container: container)
        MasterAssembly.register(container: SwinjectStoryboard.defaultContainer)
        
    }
    
    // MARK: - Tests
    
    func testCanFetchTweets() {
        
        // given
        let expectation = self.expectation(description: "Expected load tweets from fetcher")
        // Create a searchObject and fetch tweets
        guard let searchObject = SearchRouterObject(query: "wwdc2018") else { debugPrint("searchObject query parameters is nil \(#function)"); return }
        
        // when
        guard let fetcher = masterViewController.fetcher else { fatalError("Missing dependencies") }
        fetcher.search(searchRouterObject: searchObject) { (fetchedTweets, dataResponse, error) in
            
            guard let tweets = fetchedTweets, error == nil else {
                //error occured
                XCTAssertNotNil(fetchedTweets, "There should be a tweets")
                XCTAssert(false, "Tweets fetched is successfull")
                expectation.fulfill()
                return
            }
            
            XCTAssertNotNil(tweets, "There should be a tweets")
            XCTAssert(true, "Tweets fetched is successfull")
            expectation.fulfill()
        }
        
        // then
        waitForExpectations(timeout: 3, handler: nil)
    }
    
}
