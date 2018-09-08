//
//  UploadImage.swift
//  TestTaskApp
//
//  Created by Kate on 9/8/18.
//  Copyright © 2018 Kate. All rights reserved.
//

import Foundation
import UIKit

class UploadImage {
    
    var key: String
    var image: UIImage
    
    var filename: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd_hh.mm.ss"
        return "\(self.key)\(dateFormatter.string(from: Date())).png"
    }
    
    var mimeType: MimeType
    var data: Data
    
    init?(key: String, image: UIImage) {
        
        self.key = key
        self.image = image
        self.mimeType = .ImagePNG
        
        guard let data = UIImageJPEGRepresentation(image, 1.0) else { return nil }
        self.data = data
    }
}
