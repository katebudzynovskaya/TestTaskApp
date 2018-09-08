//
//  URLBuilder.swift
//  TestTaskApp
//
//  Created by Kate on 9/8/18.
//  Copyright © 2018 Kate. All rights reserved.
//

import Foundation

class URLBuilder {
    
    static let scheme = "http"
    
    static func url(host: String, endpoint: String? = nil, parameters: Parameters? = nil) -> URL? {
        
        var components = URLComponents()
        
        components.scheme = scheme
        components.host = host
        
        if let endpoint = endpoint {
            components.path = endpoint
        }
        
        if let parameters = parameters {
            components.queryItems = parameters.map{ URLQueryItem.init(name: $0, value: $1) }
        }
        
        return components.url
    }
}
