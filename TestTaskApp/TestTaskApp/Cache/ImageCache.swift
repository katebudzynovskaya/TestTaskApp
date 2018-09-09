//
//  ImageCache.swift
//  TestTaskApp
//
//  Created by Kate on 9/9/18.
//  Copyright © 2018 Kate. All rights reserved.
//

import Foundation

import UIKit

protocol ImageCache {
    
    func hasCachedImage(url: String) -> Bool
    func cachedImage(url: String, placeholder: UIImage) -> UIImage
    func image(url: String, success: @escaping (UIImage?) -> Void, failure: @escaping (Error) -> Void)
    func clearCache()
}
