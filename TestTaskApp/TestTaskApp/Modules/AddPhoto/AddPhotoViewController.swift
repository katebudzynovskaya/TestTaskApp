//
//  AddPhotoViewController.swift
//  TestTaskApp
//
//  Created by Kate on 9/9/18.
//  Copyright © 2018 Kate. All rights reserved.
//

import Foundation
import UIKit

class AddPhotoViewController: UIViewController {
    
    var imageSelector: ImageSelector!
    
    @IBOutlet weak var photo: BindingImageView! {
        didSet {
            self.photo.bind { self.viewModel.photo = Binding<UIImage>($0) }
        }
    }
    
    @IBOutlet weak var detailsInput: BindingTextField! {
        didSet {
            self.detailsInput.bind { self.viewModel.details.value = $0 }
        }
    }
    
    @IBOutlet weak var tagsInput: BindingTextField! {
        didSet {
            self.tagsInput.bind{ self.viewModel.tags.value = $0 }
        }
    }
    
    var viewModel: AddPhotoViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.requestLocation()
        
        let save = UIBarButtonItem.init(barButtonSystemItem: .save, target: self, action: #selector(saveButtonPressed))
        
        self.navigationItem.rightBarButtonItem = save
    }
    
    
    @IBAction func photoPressed(_ sender: Any) {
        
        imageSelector = ImageSelector(presenter: self)
        imageSelector.showActionSheet()
        
        imageSelector.imageDidPicked = { (image) in
            self.photo.image = image
            self.photo.contentMode = .scaleAspectFill
        }
    }
    
    @objc func saveButtonPressed() {
        
        viewModel.createPhoto(success: { [weak self] in
            
            self?.navigationController?.popViewController(animated: true)
            
        }) { [weak self] (message) in
            
            guard let sself = self else {return}
            UserMessagePresenter.showMessage(message, inController: sself)
        }
        
    }
}
