//
//  Credentials.swift
//  TestTaskApp
//
//  Created by Kate on 9/8/18.
//  Copyright © 2018 Kate. All rights reserved.
//

import Foundation

class Credentials  {
    
    let email: String
    let password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}

extension Credentials : Parameterized {
    
    var asParameters: Parameters {
        return ["email": email, "password": password]
    }
}
