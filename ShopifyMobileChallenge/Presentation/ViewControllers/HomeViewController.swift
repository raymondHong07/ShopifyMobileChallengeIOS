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
    
    private enum ButtonStyle {
        
        static let borderWidth: CGFloat = 2.0
        static let borderColor = UIColor.white.cgColor
        static let cornerRadius: CGFloat = 10
    }
    
    let shopifyManager = ShopifyManager.sharedInstance
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        styleStartButton()
        getAllProducts()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func styleStartButton() {
        
        startButton.layer.borderWidth = ButtonStyle.borderWidth
        startButton.layer.borderColor = ButtonStyle.borderColor
        startButton.layer.cornerRadius = ButtonStyle.cornerRadius
    }
    
    @IBAction func didTapStartButton(_ sender: Any) {
        
        navigationController?.pushViewController(AllTagsViewController(), animated: true)
    }
    
    private func getAllProducts() {
        
        shopifyManager.getAllProducts { (success) in
            
            if success {
                
                self.startButton.isHidden = false
                self.activityIndicator.isHidden = true
                
            } else {
                //Present alert controller for retry
            }
        }
    }
}

