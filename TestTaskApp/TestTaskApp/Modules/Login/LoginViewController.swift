//
//  LoginViewController.swift
//  TestTaskApp
//
//  Created by Kate on 9/9/18.
//  Copyright © 2018 Kate. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
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
    
    private var viewModel = LoginViewModel()
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        self.viewModel.login(success: {
            
            // navigate to image list
        }) { (message) in
            UserMessagePresenter.showMessage(message, inController: self)
        }
    }
}
