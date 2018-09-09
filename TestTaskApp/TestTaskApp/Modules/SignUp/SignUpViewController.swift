//
//  ViewController.swift
//  TestTaskApp
//
//  Created by Kate on 9/8/18.
//  Copyright © 2018 Kate. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    var imageSelector: ImageSelector!
    
    @IBOutlet weak var avatarImageView: BindingImageView! {
        didSet {
            self.avatarImageView.bind { self.viewModel.avatar = Binding<UIImage>($0) }
        }
    }
    
    @IBOutlet weak var userNameInput: BindingTextField! {
        didSet {
            self.userNameInput.bind { self.viewModel.username.value = $0 }
        }
    }
    
    @IBOutlet weak var emailInput: BindingTextField! {
        didSet {
            self.emailInput.bind { self.viewModel.email.value = $0 }
        }
    }
    
    @IBOutlet weak var passwordInput: BindingTextField! {
        didSet {
            self.passwordInput.bind { self.viewModel.password.value = $0 }
        }
    }
    
    private var viewModel = SignUpViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func signUpButtonPressed(_ sender: Any) {
        
        viewModel.signUp(success: {
            
            // navigate to image list
        }) { (message) in
           self.showMessage(message)
        }
    }
    
    @IBAction func avatarPressed(_ sender: Any) {
        
        imageSelector = ImageSelector(presenter: self)
        imageSelector.showActionSheet()
        
        imageSelector.imageDidPicked = { (image) in
            self.avatarImageView.image = image
            self.avatarImageView.contentMode = .scaleAspectFill
        }
    }
    
    func showMessage(_ message: String) {
        
        let alert = UIAlertController.init(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

