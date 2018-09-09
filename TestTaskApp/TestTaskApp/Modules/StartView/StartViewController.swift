//
//  StartViewController.swift
//  TestTaskApp
//
//  Created by Kate on 9/9/18.
//  Copyright © 2018 Kate. All rights reserved.
//

import Foundation
import UIKit

class StartViewController: UIViewController {
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    var api: APIService!
    
    var athorizationDidFinish: (() -> Void)?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let loginViewController = segue.destination as? LoginViewController {
            let loginViewModel = LoginViewModel(api: api)
            loginViewModel.loginDidFinish = self.athorizationDidFinish
            loginViewController.viewModel = loginViewModel
        }
        
        if let signUpViewController = segue.destination as? SignUpViewController {
            let signUpViewModel = SignUpViewModel(api: api)
            signUpViewModel.signUpDidFinish = self.athorizationDidFinish
            signUpViewController.viewModel = signUpViewModel
        }
    }

}


