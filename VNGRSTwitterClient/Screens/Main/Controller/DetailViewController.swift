//
//  DetailViewController.swift
//  VNGRSTwitterClient
//
//  Created by Olgu SIRMAN on 18.05.2018.
//  Copyright © 2018 Olgu SIRMAN. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet fileprivate weak var detailDescriptionLabel: UILabel!
    @IBOutlet fileprivate weak var detailImageView: TweetImageView!
    
    // MARK: - Properties
    var detailTweet: Tweet? {
        didSet {
            // Update the view.
            configureView()
        }
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    // MARK: - UpdateUI
    func configureView() {
        // Update the user interface for the detail item.
        guard let tweet = detailTweet,
            let label = detailDescriptionLabel,
            let detailImageView = detailImageView else {
            return
        }
        
        // Tweet userName
        if let userName = tweet.user?.name {
//            self.navigationItem.title = userName
            self.navigationController?.navigationItem.title = userName
        }
        
        // Set outlets
        detailImageView.setImage(to: tweet)
        detailImageView.imageHeightConstraint.constant = self.view.bounds.size.height / 2
        label.text = tweet.text
    }
    
    // MARK: - Layout
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}

