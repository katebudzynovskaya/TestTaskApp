//
//  UIImage+Location.swift
//  TestTaskApp
//
//  Created by Kate on 9/10/18.
//  Copyright © 2018 Kate. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    func location() -> Location? {
        
        guard let data = UIImageJPEGRepresentation(self, 1.0) else { return nil }
        
        let imageSource = CGImageSourceCreateWithData(data as CFData, nil)
        
        if let imageSource = imageSource {
            let metaData = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil)
            
            guard let metaDictionary = metaData as? Dictionary<String, Any>,
                let exifGPSDictionary = metaDictionary[kCGImagePropertyGPSDictionary as String] else { return nil }
            
            guard let gpsDictionary = exifGPSDictionary as? Dictionary<String, Any> else { return nil }
            
            guard let latitude = gpsDictionary["Latitude"] as? Double,
                let longitude = gpsDictionary["Longitude"] as? Double
                else { return nil }
                
            return Location(latitude: latitude, longitude: longitude)
        }

        return nil
    }
}
