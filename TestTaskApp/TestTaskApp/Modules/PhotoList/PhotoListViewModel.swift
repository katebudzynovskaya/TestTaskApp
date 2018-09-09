//
//  PhotoListViewModel.swift
//  TestTaskApp
//
//  Created by Kate on 9/9/18.
//  Copyright © 2018 Kate. All rights reserved.
//

import Foundation

class PhotoListViewModel {
    
    var photos = [PhotoViewModel]()
    var api: APIService
    var imageCache: ImageCache
    
    var didUpdate: ((PhotoListViewModel) -> Void)?
    
    init(service: APIService, cache: ImageCache) {
        
        self.api = service
        self.imageCache = cache
    }
    
    func loadPhotos() {
        
        api.loadPhotos(success: { (json) in
            
            let images: Array = json["images"] as! Array<JSONDictionary>
            
            let photos = images.map{ (dictionary: JSONDictionary) in
                return Photo.init(dictionary: dictionary)
            }
        
            self.photos = photos.map{ photo in return PhotoViewModel.init(photo: photo!, cache: self.imageCache)}
            
            DispatchQueue.main.async {
                self.didUpdate?(self)
            }
            
        }) { (error) in
            
        }
    }
}
