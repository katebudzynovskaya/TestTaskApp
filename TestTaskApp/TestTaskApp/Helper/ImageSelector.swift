//
//  ImageSelectorHelper.swift
//  TestTaskApp
//
//  Created by Kate on 9/9/18.
//  Copyright © 2018 Kate. All rights reserved.
//

import Foundation
import UIKit

class ImageSelector : NSObject {
    
    fileprivate var presenterController: UIViewController
    
    init(presenter: UIViewController) {
        self.presenterController = presenter
    }
    
    var imageDidPicked: ((UIImage) -> Void)? = nil
    
    func showActionSheet() {
        
        let actionController = UIAlertController.init(title: "Select photo", message: nil, preferredStyle: .actionSheet)
        
        let libraryAction = UIAlertAction.init(title: "from Photo Library", style: .default) { (action) in
            self.openPhotoLibrary()
        }
    
        let cameraAction = UIAlertAction.init(title: "from Camera", style: .default) { (action) in
            self.openCamera()
        }
        
        actionController.addAction(libraryAction)
        actionController.addAction(cameraAction)
        
        actionController.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.presenterController.present(actionController, animated: true, completion: nil)
    }
    
    func openPhotoLibrary() {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            
            self.presenterController.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func openCamera() {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .camera
            imagePicker.delegate = self
            
            self.presenterController.present(imagePicker, animated: true, completion: nil)
        }
    }
}

extension ImageSelector : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.presenterController.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imageDidPicked?(image)
        } else {
            print("Image selection error")
        }
        
        self.presenterController.dismiss(animated: true, completion: nil)
    }
}
