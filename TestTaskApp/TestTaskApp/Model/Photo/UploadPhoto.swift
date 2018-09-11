//
//  UploadPhoto.swift
//  TestTaskApp
//
//  Created by Kate on 9/9/18.
//  Copyright © 2018 Kate. All rights reserved.
//

import Foundation
import UIKit

class UploadPhoto {
    
    let image: LocatizedUploadImage
    let details: String?
    let tags: String?
    
    init?(image: UIImage, details: String? = nil, tags: String? = nil, location: Location?) {
        
        guard let image = LocatizedUploadImage(key: "image", image: image, location: location) else { return nil }
        
        self.image = image
        self.details = details
        self.tags = tags
    }
}


extension UploadPhoto : Parameterized {
    
    var asParameters: Parameters {
        
        return ["description": details ?? "",
                "hashtag": tags ?? "",
                "latitude": String(image.location.latitude),
                "longitude": String(image.location.longitude)]
    }
}
