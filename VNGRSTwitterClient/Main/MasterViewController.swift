//
//  MasterViewController.swift
//  VNGRSTwitterClient
//
//  Created by Olgu SIRMAN on 18.05.2018.§
//  Copyright © 2018 Olgu SIRMAN. All rights reserved.
//

import UIKit

final class MasterViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    fileprivate var detailViewController: DetailViewController? = nil
    fileprivate var tweets = [Tweet]()
    
    // MARK - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        fetchTweets()
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }
    
    fileprivate func configureTableView() {
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    private func fetchTweets() {
        let searchObject = SearchRouterObject(query: "wwdc2018")
        APIManager.shared.search(searchRouterObject: searchObject, successHandler: { (tweets) in
            if let tweets = tweets {
                self.tweets.append(contentsOf: tweets)
                self.tableView.reloadData()
            }
            
        }, failure: { error in
        })
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = tweets[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
}

// MARK: - TableViewDataSource , TableViewDelegate
extension MasterViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TweetCell
        
        let tweet = tweets[indexPath.row]
        cell.configure(tweet: tweet)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: nil)
    }
    
}

