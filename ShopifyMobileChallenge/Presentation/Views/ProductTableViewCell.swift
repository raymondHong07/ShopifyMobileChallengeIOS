//
//  ProductTableViewCell.swift
//  ShopifyMobileChallenge
//
//  Created by Raymond Hong on 2018-09-17.
//  Copyright © 2018 Raymond Hong. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var vendorLabel: UILabel!
    @IBOutlet private weak var quantityLabel: UILabel!
    @IBOutlet private weak var cellImage: UIImageView!
    
    var title: String? {
        get { return titleLabel.text ?? "" }
        set { titleLabel.text = newValue }
    }
    
    var vendor: String? {
        get { return vendorLabel.text ?? "" }
        set { vendorLabel.text = newValue }
    }
    
    var totalQuantity: Int? {
        get { return Int(quantityLabel.text ?? "0") ?? 0 }
        set { quantityLabel.text = String(describing: newValue!) }
    }
    
    var productImage: UIImage? {
        get { return cellImage.image }
        set { cellImage.image = newValue }
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
    }    
}
