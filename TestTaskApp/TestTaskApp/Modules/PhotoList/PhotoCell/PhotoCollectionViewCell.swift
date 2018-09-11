//
//  PhotoCollectionViewCell.swift
//  TestTaskApp
//
//  Created by Kate on 9/9/18.
//  Copyright © 2018 Kate. All rights reserved.
//

import Foundation
import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    
    var viewModel: PhotoViewModel!

    func setup(viewModel: PhotoViewModel) {
        
        self.weatherLabel.text = viewModel.weather
        self.thumbnail.image = viewModel.thumbnail.image
        
        if let address = viewModel.address {
            self.addressLabel.text = address
        }
        
        viewModel.thumbnail.didDownload = { [weak self] (image: UIImage) in
            self?.thumbnail.image = image
        }
        
        viewModel.thumbnail.startDownloading()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.viewModel?.reset()
    }
    
}
