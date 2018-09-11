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
        
        setupBarItems()
        bind()
        viewModel.loadPhotos()
    }
    
    func bind() {
        
        self.viewModel.didUpdate = { [weak self] _ in
            self?.collectionView?.reloadData()
        }
    }
    
    func setupBarItems() {
        
        let addButton = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addPhotoPressed))
        let gifButton = UIBarButtonItem.init(barButtonSystemItem: .play, target: self, action: #selector(gifButtonPressed))
        
        self.navigationItem.rightBarButtonItems = [addButton, gifButton]
    }
    
    @objc func addPhotoPressed() {
        let addViewController = storyboard?.instantiateViewController(withIdentifier: "AddPhotoViewController") as? AddPhotoViewController
        
        guard let addVC = addViewController else { return }
        addVC.viewModel = AddPhotoViewModel(api: viewModel.api)
        
        navigationController?.pushViewController(addVC, animated: true)
    }
    
    @objc func gifButtonPressed() {
        
        let vm = PhotoGifViewModel(api: viewModel.api)
        vm.getGif(success: { [weak self] (url) in
            
            self?.showGif(url: url)
            
        }) { [weak self] (message) -> (Void) in
            
            guard let sself = self else { return }
            UserMessagePresenter.showMessage(message, inController: sself)
        }
    }
    
    func showGif(url: URL) {
        
        let gifConroller = storyboard?.instantiateViewController(withIdentifier: "GifViewController") as? GifViewController
        
        guard let gifVC = gifConroller else { return }
       
        gifVC.gifURL = url
        gifVC.configurePopover(sourceView: self.navigationController?.navigationBar)
        
        self.present(gifVC, animated: true)
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

