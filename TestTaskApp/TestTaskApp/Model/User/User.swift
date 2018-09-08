//
//  User.swift
//  TestTaskApp
//
//  Created by Kate on 9/8/18.
//  Copyright © 2018 Kate. All rights reserved.
//

import Foundation
import UIKit

class User {
    
    let credentials: Credentials
    let avatar: UIImage
    let username: String?
    
    init(credentials: Credentials, avatar: UIImage, username: String?) {
        self.credentials = Credentials(email: credentials.email, password: credentials.password)
        self.avatar = avatar
        self.username = username
    }
}

extension User : Parameterized {
    
    var asParameters: Parameters {
        
        var parameters = credentials.asParameters
        guard let username = username else { return parameters }
        
        parameters["username"] = username
        
        return parameters
    }
}
