//
//  UITableViewCell+Reuse.swift
//  ShopifyMobileChallenge
//
//  Created by Raymond Hong on 2018-09-17.
//  Copyright © 2018 Raymond Hong. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    static var identifier: String {
        
        return String(describing: self)
    }
    
    static var nibName: String {
        
        return String(describing: self)
    }
    
    class func register(with tableView: UITableView) {
        
        tableView.register(
            UINib(nibName: nibName, bundle: nil),
            forCellReuseIdentifier: identifier)
    }
}
