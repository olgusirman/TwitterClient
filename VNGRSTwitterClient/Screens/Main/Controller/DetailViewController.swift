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
            configureView()
        }
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    // MARK: - UpdateUI
    fileprivate func configureView() {
        // Update the user interface for the detail item.
        guard let tweet = detailTweet,
            let label = detailDescriptionLabel,
            let detailImageView = detailImageView else {
            return
        }
        
        // Set outlets
        detailImageView.imageHeightConstraint.constant = self.view.bounds.size.height / 2
        detailImageView.setImage(to: tweet)
        label.text = tweet.text
    }
    
    // MARK: - Layout
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}

