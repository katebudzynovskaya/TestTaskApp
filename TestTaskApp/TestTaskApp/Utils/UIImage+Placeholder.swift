//
//  UIImage+Placeholder.swift
//  TestTaskApp
//
//  Created by Kate on 9/9/18.
//  Copyright © 2018 Kate. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

extension UIImage {
    
    static func placeholder(size: CGSize, color: UIColor, logo: UIImage?) -> UIImage {
        
        let format = UIGraphicsImageRendererFormat.preferred()
        let renderer = UIGraphicsImageRenderer(size: size, format: format)
        
        let image = renderer.image { (context) in
            
            context.cgContext.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
            
            if let logo = logo {
                
                let logoSize = logo.size
                let logoOrigin = CGPoint(x: size.width/2 - logoSize.width/2, y: size.height/2 - logoSize.height/2)
                
                logo.draw(in: CGRect(origin: logoOrigin, size: logoSize), blendMode: .softLight, alpha: 1.0)
            }
        }
        
        return image
    }
}

