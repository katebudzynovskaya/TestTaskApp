//
//  LocalizedUploadImage.swift
//  TestTaskApp
//
//  Created by Kate on 9/10/18.
//  Copyright © 2018 Kate. All rights reserved.
//

import Foundation
import UIKit

typealias Location = (latitude: Double, longitude: Double)

protocol Localized {
    var location: Location {get}
}

class LocatizedUploadImage: UploadImage, Localized {
    
    var location = Location(latitude: 0.0,longitude: 0.0)
    
    init?(key: String, image: UIImage, location: Location?) {
        
        super.init(key: key, image: image)
        
        self.key = key
        self.image = image
        self.mimeType = .ImagePNG
        
        guard let data = UIImageJPEGRepresentation(image, 1.0) else { return nil }
        self.data = data
        
        if let imageLocation = self.image.location() {
            self.location = imageLocation
        }
        else {
            self.location = location ?? Location(0,0)
        }
    }
}


