//
//  BindingImageView.swift
//  TestTaskApp
//
//  Created by Kate on 9/9/18.
//  Copyright © 2018 Kate. All rights reserved.
//

import Foundation
import UIKit

class BindingImageView: UIImageView {
    
    override var image: UIImage? {
        didSet {
            self.imageDidChange(image!)
        }
    }
    
    var imageDidChange: (UIImage) -> Void = { _ in}
    
    func bind(callback: @escaping (UIImage) -> ()) {
        
        self.imageDidChange = callback
    }
}
