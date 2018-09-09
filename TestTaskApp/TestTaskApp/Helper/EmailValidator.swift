//
//  EmailValidator.swift
//  TestTaskApp
//
//  Created by Kate on 9/9/18.
//  Copyright © 2018 Kate. All rights reserved.
//

import Foundation

class EmailValidator {
    
    static func isValid(_ email: String) -> ValidationResult {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        guard NSPredicate(format:"SELF MATCHES %@", emailRegEx).evaluate(with: email) else {
            return (false, "Email format is invalid, please check")
        }
        
        return (true, "")
    }
}
