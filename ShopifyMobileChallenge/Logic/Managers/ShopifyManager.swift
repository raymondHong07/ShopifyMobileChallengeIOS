//
//  ShopifyManager.swift
//  ShopifyMobileChallenge
//
//  Created by Raymond Hong on 2018-09-16.
//  Copyright © 2018 Raymond Hong. All rights reserved.
//

import UIKit
import Alamofire


final class ShopifyManager {
    
    private enum Request {
        
        static let pageNumber = 1
        static let token = "c32313df0d0ef512ca64d5b336a0d7c6"
    }
    
    static let sharedInstance = ShopifyManager()
    var allProducts: [Product] = []
    var allTags: [String] = []
    
    func getAllProducts(completion: @escaping (Bool) -> Void) {
        
        let requestURL = String(format: "https://shopicruit.myshopify.com/admin/products.json?page=%d&access_token=%@", Request.pageNumber, Request.token)
        
        Alamofire.request(requestURL).responseJSON { response in
            
            switch response.result {
                
            case .success:
                if let json = response.result.value as? [String: Any] {
                    
                    if let products = json["products"] as? [[String: Any]] {
                        
                        for product in products {
                            
                            let finalProduct: Product = Product()
                            
                            // Get all product info
                            finalProduct.title = product["title"] as? String ?? ""
                            finalProduct.vendor = product["vendor"] as? String ?? ""
                            finalProduct.tags = self.getAllProductTags(for: product)
                            finalProduct.totalAvail = self.getTotalInventory(for: product)
                            
                            if let images = product["images"] as? [[String: Any]] {
                                
                                if let image = images.first?["src"],
                                let imageUrl = image as? String {
                                    
                                    ImageManager.shared.imageForUrl(urlString: imageUrl, completionHandler: { (resultImage) in
                                        
                                        if let productImage = resultImage {
                                            
                                            finalProduct.productImage = productImage
                                        }
                                    })
                                }
                            }
                            
                            self.allProducts.append(finalProduct)
                        }
                    }
                }
        
            case .failure(let error):
                print(error)
                
            }
            
            completion(true)
        }
    }
    
    private func getAllProductTags(for product: [String: Any]) -> [String] {
        
        var allProductTags: [String] = []
        
        // Get product tags and add unique tags to array
        if let tags = product["tags"] as? String {
            
            allProductTags = tags.components(separatedBy: ", ")
            
            for tag in allProductTags {
                
                if !self.allTags.contains(tag) {
                    
                    self.allTags.append(tag)
                }
            }
        }
        
        return allProductTags
    }
    
    private func getTotalInventory(for product: [String: Any]) -> Int {
        
        var totalInventory = 0
        
        // Get sum of total inventory across all variants
        if let variants = product["variants"] as? [[String: Any]] {
            
            for variant in variants {
                
                if let inventory = variant["inventory_quantity"] as? Int {
                    
                    totalInventory += inventory
                }
            }
        }
        
        return totalInventory
    }
}
