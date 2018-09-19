//
//  ImageManager.swift
//  ShopifyMobileChallenge
//
//  Created by Raymond Hong on 2018-09-18.
//  Copyright © 2018 Raymond Hong. All rights reserved.
//

import UIKit

// A light weight class for downloading image data asynchronously.
class ImageManager {
    
    static let shared: ImageManager = {
        
        let instance = ImageManager()
        instance.setUp()
        
        return instance
    }()
    
    private func setUp() {
        
    }
    
    func imageForUrl(urlString: String, completionHandler:@escaping (_ image: UIImage?) -> Void) {
        
        guard !urlString.isEmpty else {
            
            completionHandler(nil)
            return
        }
        
        if let url = URL(string: urlString) {
            
            // Asyncrhonously download the image.
            //
            URLSession.shared.dataTask(with: url) { data, _ /*response*/, error in
                
                if error == nil && data != nil {
                    
                    let image = UIImage(data: data!)
                    
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
