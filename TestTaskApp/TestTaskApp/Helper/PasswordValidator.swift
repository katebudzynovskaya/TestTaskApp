//
//  PasswordValidator.swift
//  TestTaskApp
//
//  Created by Kate on 9/9/18.
//  Copyright © 2018 Kate. All rights reserved.
//

import Foundation

class PasswordValidator {
    
    static func isValid(_ password: String) -> ValidationResult {
        
        if password.count < 6 {
            return ValidationResult(false, "Password should be at least 6 characters long ")
        }
        
        return (true, "")
    }
}


