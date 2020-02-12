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
        
    override func awakeFromNib() {
        
        super.awakeFromNib()
    }
    
    func configure(with product: Products.Product) {
        
        selectionStyle = .none
        
        titleLabel.text = product.title ?? ""
        vendorLabel.text = product.vendor ?? ""
        quantityLabel.text = String(ProductsHelper.getTotalInventory(for: product))
        
        // Download image via image url from helper
        ProductsHelper.getImage(for: product) { (image) in
            
            if let productImage = image {
                
                self.cellImage.image = productImage
            }
        }
    }
}
