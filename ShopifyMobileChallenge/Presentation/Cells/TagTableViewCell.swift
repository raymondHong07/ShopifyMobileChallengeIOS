//
//  TagTableViewCell.swift
//  ShopifyMobileChallenge
//
//  Created by Raymond Hong on 2018-09-17.
//  Copyright © 2018 Raymond Hong. All rights reserved.
//

import UIKit

final class TagTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    
    var title: String? {
        
        get { return titleLabel.text ?? "" }
        set { titleLabel.text = newValue }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
