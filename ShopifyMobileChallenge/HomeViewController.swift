//
//  ViewController.swift
//  ShopifyMobileChallenge
//
//  Created by Raymond Hong on 2018-09-13.
//  Copyright © 2018 Raymond Hong. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
    
    @IBOutlet private weak var startButton: UIButton!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    let shopifyManager = ShopifyManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Style button
        startButton.layer.borderWidth = 2.0
        startButton.layer.borderColor = UIColor.white.cgColor
        startButton.layer.cornerRadius = 10.0
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        // Make request to get all products
        shopifyManager.getAllProducts { (success) in
            
            if success {
                
                self.startButton.isHidden = false
                self.activityIndicator.isHidden = true
                
            } else {
                //Present alert controller for retry
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @IBAction func didTapStartButton(_ sender: Any) {
        
        navigationController?.pushViewController(AllTagsViewController(), animated: true)
    }
    
}

