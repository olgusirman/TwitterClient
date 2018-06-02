//
//  DetailViewController.swift
//  VNGRSTwitterClient
//
//  Created by Olgu SIRMAN on 18.05.2018.
//  Copyright © 2018 Olgu SIRMAN. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {

    // MARK - Properties
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    var detailItem: Tweet? {
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

    // MARK - UpdateUI
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.text
            }
        }
    }
}

