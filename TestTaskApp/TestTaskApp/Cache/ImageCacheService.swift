//
//  ImageCacheService.swift
//  TestTaskApp
//
//  Created by Kate on 9/9/18.
//  Copyright © 2018 Kate. All rights reserved.
//

import Foundation
import UIKit

class ImageCacheService : ImageCache {
    
    let service: APIService
    var cache = NSCache<NSString, NSPurgeableData>()
    
    init(service: APIService) {
        
        self.service = service
        self.cache.evictsObjectsWithDiscardedContent = true
    }
    
    func hasCachedImage(url: String) -> Bool {
        
        guard let _ = cache.object(forKey: url as NSString)
            else { return false}
        
        return true
    }
    
    func cachedImage(url: String, placeholder: UIImage) -> UIImage {
        
        var image: UIImage?
        
        if let data = cache.object(forKey: url as NSString) {
            
            data.beginContentAccess()
            image = UIImage(data: data as Data)
            data.endContentAccess()
        }
        
        return image ?? placeholder
        
    }
    
    func image(url: String, success: @escaping (UIImage?) -> Void, failure: @escaping (Error) -> Void) {
        
        self.service.executeRequest(url: url, success: { [weak self] (data) in
            
            let purgeableData = NSPurgeableData(data: data)
            self?.cache.setObject(purgeableData, forKey: url as NSString)
            
            let image = UIImage(data: purgeableData as Data)
            purgeableData.endContentAccess()
            
            success(image)
            
        }) { (error) in
            
            failure(error)
        }
    }
    
    func clearCache() {
        self.cache.removeAllObjects()
    }
}

