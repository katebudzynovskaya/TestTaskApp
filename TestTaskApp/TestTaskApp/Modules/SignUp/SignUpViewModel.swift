//
//  SignUpViewModel.swift
//  TestTaskApp
//
//  Created by Kate on 9/8/18.
//  Copyright © 2018 Kate. All rights reserved.
//

import Foundation
import UIKit

typealias ValidationResult = (valid: Bool, message: String)

class SignUpViewModel {
    
    let api: APIService
    
    var username = Binding<String>("")
    var email = Binding<String>("")
    var password = Binding<String>("")
    var avatar: Binding<UIImage>!
    
    var signUpDidFinish: (() -> (Void))?
    
    init(api: APIService) {
        self.api = api
    }
    
    func signUp(success: @escaping () -> (Void), failure: @escaping (String) -> Void) {
        
        let result = isValid()
        
        if result.valid {
            
            let credentials = Credentials(email: email.value!, password: password.value!)
            let user = User.init(credentials: credentials, avatar: (avatar?.value)!, username: username.value!)
            
            api.signUp(user: user, success: {
                
                DispatchQueue.main.async {
                    success()
                }
                
            }, failure: { (error) in
        
                switch error {
                case .Error(let result):
                    
                    DispatchQueue.main.async {
                        failure(result)
                    }
                }
            })
        }
        else { failure(result.message) }
    }
    
    private func isValid() -> ValidationResult {
        
        guard let email = email.value, !email.isEmpty,
            let password = password.value, !password.isEmpty,
            let _ = avatar?.value
        else {
            return ValidationResult(false, "Avatar, email and password should not be empty, please fill them in")
        }
        
        let emailValidation = EmailValidator.isValid(email)
        guard emailValidation.valid else {
            return emailValidation
        }
        
        let passwordValidation = PasswordValidator.isValid(password)
        guard passwordValidation.valid else {
            return passwordValidation
        }
        
        return ValidationResult(true, "")
    }
    
}
