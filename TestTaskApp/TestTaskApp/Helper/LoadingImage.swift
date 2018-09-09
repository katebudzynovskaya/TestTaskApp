//
//  LoadingImage.swift
//  TestTaskApp
//
//  Created by Kate on 9/9/18.
//  Copyright © 2018 Kate. All rights reserved.
//

import Foundation
import UIKit

class LoadingImage {
    
    enum State {
        case ready
        case cached
        case downloading
        case failed
    }
    
    var cache: ImageCache
    var state: State = .ready
    var url: String
    
    var didDownload: ((UIImage) -> Void)?
    
    var image: UIImage {
        
        let logo = UIImage(named: "photo")
        let size = CGSize(width: 100, height: 100)
        let placeholder = UIImage.placeholder(size: size, color: UIColor.lightGray, logo: logo)
        return self.cache.cachedImage(url: self.url, placeholder: placeholder)
    }
    
    init(url: String, cache: ImageCache) {
        
        self.url = url
        self.cache = cache
        
        if cache.hasCachedImage(url: url) { state = .cached }
    }
    
    func startDownloading() {
        
        if state == .cached {
            didDownload?(image)
        }
        else {
            
            self.state = .downloading
            cache.image(url: url, success: { [weak self] (image) in
                
                guard let strongSelf = self else { return }
                
                if let image = image {
                    strongSelf.state = .cached
                    strongSelf.didDownload?(image)
                }
                else {
                    strongSelf.state = .failed
                }
                
                }, failure: { [weak self] (error) in
                    
                    guard let strongSelf = self else { return }
                    strongSelf.state = .failed
            })
        }
    }
}

