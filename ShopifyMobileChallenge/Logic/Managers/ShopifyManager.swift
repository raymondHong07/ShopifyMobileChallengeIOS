//
//  ShopifyManager.swift
//  ShopifyMobileChallenge
//
//  Created by Raymond Hong on 2018-09-16.
//  Copyright © 2018 Raymond Hong. All rights reserved.
//

import UIKit

struct Products: Codable {
    
    var products: [Product]
    
    struct Product: Codable {
        var title: String?
        var vendor: String?
        var tags: String?
        var variants: [Variant]
        var image: Image
    }
}
struct Variant: Codable {
    var inventory_quantity: Int?
}
struct Image: Codable {
    var src: String?
}

final class ShopifyManager {
    
    private enum Request {
        
        static let pageNumber = 1
        static let token = "c32313df0d0ef512ca64d5b336a0d7c6"
        static let url = "https://shopicruit.myshopify.com/admin/products.json?page=%d&access_token=%@"
    }
    
    static let sharedInstance = ShopifyManager()
    var allProducts: [Products.Product] = []
    var allTags: [String] = []
    
    func getAllProducts(completion: @escaping (Bool) -> Void) {
        
        // Set request url with reference to Request enum for easy modification
        let requestUrlString = String(format: Request.url,
                                      Request.pageNumber,
                                      Request.token)
        
        guard let url = URL(string: requestUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            if err != nil {
                
                completion(false)
                
            } else {
                
                let decoder = JSONDecoder()
                guard let data = data else { return }
                
                do {
                    let allProductData = try decoder.decode(Products.self, from: data)
                    for product in allProductData.products {
                        
                        self.getAllUniqueProductTags(from: product)
                        self.allProducts.append(product)
                    }
                    self.allTags.sort()
                } catch {
                    //Failed to decode JSON
                    completion(false)
                }
            }
        }.resume()
        
        completion(true)
    }
    
    private func getAllUniqueProductTags(from product: Products.Product) {

        // add unique tags to array
        if let tags = product.tags {

            let allProductTags = tags.components(separatedBy: ", ")
            for tag in allProductTags {
                
                if !self.allTags.contains(tag) {
                    
                    self.allTags.append(tag)
                }
            }
        }
    }
}
