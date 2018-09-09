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
    
    var viewModel: LoginViewModel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        self.viewModel.login(success: {
            
            self.navigationController?.popViewController(animated: false)
            self.viewModel.loginDidFinish?()
            
        }) { (message) in
            UserMessagePresenter.showMessage(message, inController: self)
        }
    }
}
