//
//  ImageManager.swift
//  ShopifyMobileChallenge
//
//  Created by Raymond Hong on 2018-09-18.
//  Copyright © 2018 Raymond Hong. All rights reserved.
//

import UIKit

// A light weight class for downloading image data asynchronously.
// Also supports caching images.
//
class ImageManager {
    
    private var cache = NSCache<AnyObject, AnyObject>()
    
    static let shared: ImageManager = {
        
        let instance = ImageManager()
        instance.setUp()
        
        return instance
    }()
    
    private func setUp() {
        
    }
    
    func imageForUrl(
        urlString: String,
        completionHandler:@escaping (_ image: UIImage?) -> Void) {
        
        guard !urlString.isEmpty else {
            
            completionHandler(nil)
            return
        }
        
        let data: NSData? = cache.object(forKey: urlString as AnyObject) as? NSData
        
        if let imageData = data {
            
            // Use cached image data.
            //
            let image = UIImage(data: imageData as Data)
            
            DispatchQueue.main.async {
                
                completionHandler(image)
            }
            
            return
            
        } else if let url = URL(string: urlString) {
            
            // Asyncrhonously download the image.
            //
            URLSession.shared.dataTask(with: url) { data, _ /*response*/, error in
                
                if error == nil && data != nil {
                    
                    let image = UIImage(data: data!)
                    
                    self.cache.setObject(data! as AnyObject, forKey: urlString as AnyObject)
                    
                    DispatchQueue.main.async {
                        
                        completionHandler(image)
                    }
                    
                } else {
                    
                    DispatchQueue.main.async {
                        
                        completionHandler(nil)
                    }
                }
                
                }.resume()
            
        } else {
            
            completionHandler(nil)
        }
    }
}
