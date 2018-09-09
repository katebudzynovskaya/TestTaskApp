//
//  PhotoListViewController.swift
//  TestTaskApp
//
//  Created by Kate on 9/9/18.
//  Copyright © 2018 Kate. All rights reserved.
//

import Foundation
import UIKit

class PhotoListViewController : UICollectionViewController {
    
    var viewModel: PhotoListViewModel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = true
        
        bind()
        viewModel.loadPhotos()
    }
    
    func bind() {
        
        self.viewModel.didUpdate = { [weak self] _ in
            self?.collectionView?.reloadData()
        }
    }
}

extension PhotoListViewController  {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        let photo = viewModel.photos[indexPath.item]
        
        cell.setup(viewModel: photo)
        
        return cell
    }
}

