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
//import SystemConfiguration
import Reachability

final class MasterViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet fileprivate weak var searchBar: UISearchBar!
    
    // MARK: - Properties
    
    // MARK: Dependency
    var fetcher: TweetFetcher?
    
    // MARK: Private
    fileprivate var tweets = [Tweet]() {
        didSet {
            // update the sinceId
            self.updateTheLastId()
        }
    }
    fileprivate let disposeBag = DisposeBag()
    
    fileprivate var sinceId = 0
    fileprivate var isLoading = false
    
//    private let reachability = SCNetworkReachabilityCreateWithName(nil, "www.raywenderlich.com")
    private let reachability = Reachability()!
    
    // Private Constants
    fileprivate enum ControllerConstants {
        static let tweetCellIdentifier = "tweetCell"
        static let tweetImageCellIdentifier = "tweetWithImageCell"
        static let initialSearchText = "wwdc2018"
        static let tweetDetailSegueIdentifier = "showDetail"
    }
    
    // MARK - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSplitViewController()
        configureTableView()
        fetchTweets(searchText: ControllerConstants.initialSearchText) { isSuccess, tweets in }
        configureSearch()
//        checkReachable()
         setReachabilityNotifier()
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == ControllerConstants.tweetDetailSegueIdentifier else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
        let object = tweets[indexPath.row]
        if let controller = (segue.destination as? UINavigationController)?.topViewController as? DetailViewController {
            controller.detailTweet = object
            controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = true
        }
    }
    
    func fetchTweets( searchText: String, completionHandler: @escaping ( _ isFetched: Bool, _ tweets:[Tweet]?) -> Void ) {
        
        guard !searchText.isEmpty && !self.isLoading else {
            // Maybe show emptyDataSet there
            completionHandler(false, nil)
            return
        }
        
        // Create a searchObject and fetch tweets
        guard let searchObject = SearchRouterObject(query: searchText) else { debugPrint("searchObject query parameters is nil \(#function)"); return }
        
        isLoading = true
        
        guard let fetcher = fetcher else { fatalError("Missing dependencies") }
        fetcher.search(searchRouterObject: searchObject) { [weak self] (tweets, dataResponse, error) in
            
            guard let tweets = tweets, error == nil else {
                self?.updateUI()
                completionHandler(false, nil)
                //error occured
                return
            }
            
            self?.updateUI(tweets: tweets)
            completionHandler(true, tweets)
            
        }
    }
    
}

// MARK: Private Helpers
extension MasterViewController {
    
    // MARK: Reachability
    fileprivate func setReachabilityNotifier () {
        //declare this inside of viewWillAppear
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi:
            print("Reachable via WiFi")
        case .cellular:
            print("Reachable via Cellular")
        case .none:
            print("Network not reachable")
        }
    }
    
    // MARK: Reachability SC
    /*
    fileprivate func checkReachable() {
        
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(self.reachability!, &flags)
        
        if (isNetworkReachable(with: flags))
        {
            print (flags)
            if flags.contains(.isWWAN) {
                self.alert(message:"via mobile",title:"Reachable")
                return
            }
            
            self.alert(message:"via wifi",title:"Reachable")
        }
        else if (!isNetworkReachable(with: flags)) {
            self.alert(message:"Sorry no connection",title: "unreachable")
            print (flags)
            return
        }
    }
    
    private func isNetworkReachable(with flags: SCNetworkReachabilityFlags) -> Bool {
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        let canConnectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
        let canConnectWithoutUserInteraction = canConnectAutomatically && !flags.contains(.interventionRequired)
        return isReachable && (!needsConnection || canConnectWithoutUserInteraction)
    }
    */
    
    // MARK: Configure SplitViewController
    fileprivate func configureSplitViewController() {
        
        guard let split = splitViewController else {
            return
        }
        
        let controllers = split.viewControllers
        guard let navigationController = controllers[controllers.count-1] as? UINavigationController else { return }
        guard let detailViewController = navigationController.topViewController as? DetailViewController else { return }
        detailViewController.navigationItem.leftBarButtonItem = split.displayModeButtonItem
        split.delegate = self
        
    }
    
    // MARK: Configure SearchBar
    fileprivate func configureSearch() {
        
        searchBar.delegate = self
        searchBar.text = ControllerConstants.initialSearchText
        searchBar.rx.text
            .orEmpty
            .debounce(1.0, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe { [unowned self] (query) in
                
                if let element = query.element {
                    self.fetchTweets(searchText: element) { isSuccess, tweets in }
                    debugPrint("query: \(element)")
                }
                
            }.disposed(by: disposeBag)
        
    }
    
    // MARK: Configure TableView
    fileprivate func configureTableView() {
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    // MARK: Update methods
    fileprivate func updateUI( tweets: [Tweet]? = nil ) {
        
        if let tweets = tweets {
            // Use tweets for initial array
            self.tweets = tweets
        }
        
        self.isLoading = false
        self.tableView.reloadData()
    }
    
    fileprivate func appendMoreTweets() {
        
        guard let fetcher = fetcher else { fatalError("Fetcher has not been injected") }
        guard let searchText = searchBar.text, !searchText.isEmpty && !self.isLoading else {
            // Maybe show emptyDataSet there
            return
        }
        
        // Create a searchObject and fetch tweets
        var searchObject = SearchRouterObject(query: searchText)
        searchObject?.maxId = self.sinceId
        
        isLoading = true
        fetcher.search(searchRouterObject: searchObject!) { [weak self] (tweets, dataResponse, error) in
            
            guard let tweets = tweets, error == nil && tweets.count > 0 else {
                //error occured
                self?.updateUI()
                return
            }
            
            var clonedTweets = tweets
            clonedTweets.removeFirst()
            self?.tweets.append(contentsOf: clonedTweets)
            self?.tableView.reloadData()
            self?.isLoading = false
        }
        
        /*
        APIManager.search(searchRouterObject: searchObject!, successHandler: { (tweets) in
            //self.updateUI(tweets: tweets)
            if let tweets = tweets {
                var tweets = tweets
                tweets.removeFirst()
                self.tweets.append(contentsOf: tweets)
                self.tableView.reloadData()
            }
            self.isLoading = false
            
        }, failure: { error in
            self.updateUI()
        })*/
    }
    
    fileprivate func updateTheLastId() {
        if let lastTweetId = self.tweets.last?.id {
            self.sinceId = lastTweetId
        }
    }
    
}

extension MasterViewController: UISplitViewControllerDelegate {
    
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

// MARK: - TableViewDataSource , TableViewDelegate
extension MasterViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: TweetCell
        if tweets[indexPath.row].entities?.media?.first?.mediaUrl != nil {
            cell = tableView.dequeueReusableCell(withIdentifier: ControllerConstants.tweetImageCellIdentifier, for: indexPath) as! TweetCell
            cell.entityImageView.image = nil
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: ControllerConstants.tweetCellIdentifier, for: indexPath) as! TweetCell
        }
        
        var tweet = tweets[indexPath.row]
        tweet.indexPath = indexPath
        cell.configure(tweet: tweet)
        cell.delegate = self
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: ControllerConstants.tweetDetailSegueIdentifier, sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tweet = tweets[indexPath.row]
        return tweet.configureCellHeight()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentSize.height - (scrollView.contentOffset.y + scrollView.bounds.size.height) <= 100 && !self.isLoading {
            appendMoreTweets()
        }
    }
}

extension MasterViewController: TweetCellDelegate {
    
    func imageLoaded(with image: UIImage?, with indexPath: IndexPath?) {
        //debugPrint("\(String(describing: image)) loaded")
    }
    
}

extension MasterViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, tweets.count != 0 else { return }
        fetchTweets(searchText: searchText) { isSuccess, tweets in }
        self.view.endEditing(true)
    }
}
