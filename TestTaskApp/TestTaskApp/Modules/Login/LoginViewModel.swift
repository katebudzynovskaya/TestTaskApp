//
//  LoginViewModel.swift
//  TestTaskApp
//
//  Created by Kate on 9/9/18.
//  Copyright © 2018 Kate. All rights reserved.
//

import Foundation

class LoginViewModel {
    
    let api: APIService
    
    var email = Binding<String>("")
    var password = Binding<String>("")
    
    var loginDidFinish: (() -> (Void))?
    
    init(api: APIService) {
        self.api = api
    }
    
    func login(success: @escaping () -> Void, failure: @escaping (String) -> Void) {
            
        let result = isValid()
        
        if result.valid {
            
            let credentials = Credentials(email: email.value!, password: password.value!)
            
            api.signIn(withCredentials: credentials, success: {
                
                DispatchQueue.main.async {
                    success()
                }
                
            }) { (error) in
                
                switch error {
                case .Error(let result):
                    
                    DispatchQueue.main.async {
                        failure(result)
                    }
                }
            }
        }
        else {
            failure(result.message)
        }
    }
    
    private func isValid() -> ValidationResult {
        
        guard let email = email.value, !email.isEmpty,
            let password = password.value, !password.isEmpty
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
