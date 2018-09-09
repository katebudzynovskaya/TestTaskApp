//
//  PhotoViewModel.swift
//  TestTaskApp
//
//  Created by Kate on 9/9/18.
//  Copyright © 2018 Kate. All rights reserved.
//

import Foundation

class PhotoViewModel {
    
    var weather: String
    var address: String?
    var thumbnail: LoadingImage
    
    init(photo: Photo, cache: ImageCache) {
        
        self.weather = photo.weather
        self.address = photo.address
        
        self.thumbnail = LoadingImage(url: photo.thumbnailURL, cache: cache)
    }
    
    func reset() {
        
        self.thumbnail.didDownload = nil
        self.thumbnail.state = .ready
    }
}
