//
//  Photo.swift
//  TestTaskApp
//
//  Created by Kate on 9/9/18.
//  Copyright © 2018 Kate. All rights reserved.
//

import Foundation

class Photo {
    
    let id: Int
    let weather: String
    let thumbnailURL: String
    let sourceImageURL: String
    var address: String? = nil
    
    init?(dictionary: JSONDictionary) {
        
        guard let id = dictionary["id"] as? Int,
            let thumbnail = dictionary["smallImagePath"] as? String,
            let sourceImage = dictionary["bigImagePath"] as? String,
            let params = dictionary["parameters"] as? JSONDictionary,
            let weather = params["weather"] as? String
            else { return nil }
        
        self.id = id
        self.weather = weather
        self.thumbnailURL = thumbnail
        self.sourceImageURL = sourceImage
        
        if let address = params["address"] as? String {
            self.address = address
        }
    }
}
