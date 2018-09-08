//
//  APIService.swift
//  TestTaskApp
//
//  Created by Kate on 9/8/18.
//  Copyright © 2018 Kate. All rights reserved.
//

import Foundation

class APIService: API {
    
    let host = "api.doitserver.in.ua"
    
    let session: URLSession = URLSession(configuration: URLSessionConfiguration.default)
    
    func signUp(user: User, success: @escaping (Data) -> Void, failure: @escaping (APIError) -> Void) {
        
        let parameters = user.asParameters
        let avatar = UploadImage.init(key: "avatar", image: user.avatar)
        
        guard let request = RequestBuilder.POSTMultipartRequest(host: host, endpoint: .SignUp, parameters: parameters, image: avatar, token: nil)
            else {
                failure(.InvalidRequestError("Invalid POST request"))
                return }
        
        self.session.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                failure(APIError.SignUpError(error.localizedDescription))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse,
                let responseError = APIError.init(code: httpResponse.statusCode) {
                failure(responseError)
                return
            }
            
            if let data = data,
                let json = try? JSONSerialization.jsonObject(with: data) {
                
                let response = json as! JSONDictionary
                let token = response["token"] as? String
                
            } else {
                failure(APIError.SerializationError("API response cannot be serialized"))
            }

            
        }.resume()
    }
    
    func signIn(withCredentials credentials: Credentials,  success: @escaping (Data) -> Void, failure: @escaping (APIError) -> Void) {
        let parameters = credentials.asParameters
        
        guard let reuest = RequestBuilder.POSTMultipartRequest(host: host, endpoint: .SignIn, parameters: parameters, image: nil, token: nil)
            else {
                failure(.InvalidRequestError("Invalid POST request"))
                return }
        
        self.session.dataTask(with: reuest) { (data, response, error) in
            
            if let error = error {
                failure(APIError.SignInError(error.localizedDescription))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse,
                let responseError = APIError.init(code: httpResponse.statusCode) {
                failure(responseError)
                return
            }
            
            if let data = data,
                let json = try? JSONSerialization.jsonObject(with: data) {
                
                let response = json as! JSONDictionary
                let token = response["token"] as? String

            } else {
                failure(APIError.SerializationError("API response cannot be serialized"))
            }
            
        }.resume()
    }
}
