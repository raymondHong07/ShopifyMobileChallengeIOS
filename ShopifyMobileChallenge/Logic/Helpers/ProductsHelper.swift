//
//  ProductsHelper.swift
//  ShopifyMobileChallenge
//
//  Created by Raymond Hong on 2020-01-31.
//  Copyright © 2020 Raymond Hong. All rights reserved.
//

import Foundation
import UIKit

final class ProductsHelper {
    
    class func does(product: Products.Product, contain tag: String) -> Bool {

        var productTags: [String] = []

        // Get product tags
        if let tags = product.tags {
            
            productTags = tags.components(separatedBy: ", ")
        }
        
        return productTags.contains(tag)
    }
    
    class func getTotalInventory(for product: Products.Product) -> Int {

        var totalInventory = 0
        
        // Get sum of total inventory across all variants
        for variant in product.variants {
            
            if let inventory = variant.inventory_quantity {
                
                totalInventory += inventory
            }
        }

        return totalInventory
    }
    
    class func getImage(for product: Products.Product, completion: @escaping (_ productImage: UIImage?) -> Void) {
        
        // Download image url and set product image
        if let imageUrl = product.image.src {
            
            ImageManager.shared.imageForUrl(urlString: imageUrl) { (productImage) in
                
                completion(productImage)
            }
        }
    }
}
