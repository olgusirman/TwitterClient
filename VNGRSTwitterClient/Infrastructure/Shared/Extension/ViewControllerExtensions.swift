//
//  ViewControllerExtensions.swift
//  VNGRSTwitterClient
//
//  Created by Olgu on 18.07.2018.
//  Copyright © 2018 Olgu SIRMAN. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let oKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(oKAction)
        
        DispatchQueue.main.async  {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
