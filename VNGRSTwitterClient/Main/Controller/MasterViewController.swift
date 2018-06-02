//
//  MasterViewController.swift
//  VNGRSTwitterClient
//
//  Created by Olgu SIRMAN on 18.05.2018.
//  Copyright © 2018 Olgu SIRMAN. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class MasterViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet fileprivate weak var searchBar: UISearchBar!
    
    fileprivate var detailViewController: DetailViewController? = nil
    fileprivate var tweets = [Tweet]()
    fileprivate var filteredTweets = [Tweet]()
    
    // MARK - Lifecycle
    fileprivate lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.fetchTweets), for: .valueChanged)
        return refreshControl
    }()
    fileprivate let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        fetchTweets()
        configureSearch()
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }
    
    fileprivate func configureSearch() {
        
        searchBar.rx.text
            .orEmpty
            .throttle(0.7, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe { [unowned self] (query) in
                
                //debugPrint(query)
                
                self.filteredTweets = self.tweets.search(query: query)
                self.tableView.reloadData()
                
            }.disposed(by: disposeBag)
        
    }
    
    fileprivate func configureTableView() {
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.refreshControl = refreshControl
        tableView.addSubview(self.refreshControl)
    }
    
    @objc private func fetchTweets() {
        let searchObject = SearchRouterObject(query: "wwdc2018")
        APIManager.shared.search(searchRouterObject: searchObject, successHandler: { (tweets) in
            
            self.updateUI(tweets: tweets)
            
        }, failure: { error in
            self.updateUI()
        })
    }
    
    fileprivate func updateUI( tweets: [Tweet]? = nil ) {
        
        if let tweets = tweets {
            self.tweets.append(contentsOf: tweets)
            self.filteredTweets.append(contentsOf: tweets)
        }
        
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
        
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = filteredTweets[indexPath.row]
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
        return filteredTweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TweetCell
        
        let tweet = filteredTweets[indexPath.row]
        cell.configure(tweet: tweet)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
