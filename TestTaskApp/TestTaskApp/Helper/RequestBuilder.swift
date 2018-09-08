//
//  RequestBuilder.swift
//  TestTaskApp
//
//  Created by Kate on 9/8/18.
//  Copyright © 2018 Kate. All rights reserved.
//

import Foundation

class RequestBuilder {
    
    static var boundary: String {
        return "\(UUID().uuidString)"
    }
    
    static func GETRequest(host: String, endpoint: Endpoint, token: String, parameters: Parameters = [:]) -> URLRequest? {
        
        guard let url = URLBuilder.url(host: host, endpoint: endpoint.rawValue, parameters: parameters)
            else { return nil }
        
        var request = URLRequest.init(url: url)
        request.httpMethod = HttpMethod.GET.rawValue
        request.addValue(token, forHTTPHeaderField: "token")
        
        return request
    }
    
    static func POSTMultipartRequest(host: String, endpoint: Endpoint, parameters: Parameters?, image: UploadImage?, token: String?) -> URLRequest? {
        
        guard let url = URLBuilder.url(host: host, endpoint: endpoint.rawValue)
            else { return nil }
        
        var request = URLRequest.init(url: url)
        
        request.httpMethod = HttpMethod.POST.rawValue
        let boundary = self.boundary
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpBody = createBody(parameters: parameters, image: image, boundary: boundary)
        
        if let token = token {
            request.addValue(token, forHTTPHeaderField: "token")
        }
        
        return request
    }
    
    private static func createBody(parameters: Parameters?, image: UploadImage?, boundary: String) -> Data {
        
        let lineBreak = "\r\n"
        var body = Data()
        
        if let parameters = parameters {
            for (key, value) in parameters {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                body.append("\(value + lineBreak)")
            }
        }
        
        if let image = image {
            body.append("--\(boundary + lineBreak)")
            body.append("Content-Disposition: form-data; name=\"\(image.key)\"; filename=\"\(image.filename)\"\(lineBreak)")
            body.append("Content-Type: \(image.mimeType.rawValue + lineBreak + lineBreak)")
            body.append(image.data)
            body.append(lineBreak)
        }
        
        body.append("--\(boundary)--\(lineBreak)")
        
        return body
    }
}
