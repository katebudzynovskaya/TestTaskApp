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
    private(set) var token: String?
    
    let session: URLSession = URLSession(configuration: URLSessionConfiguration.default)
    
    func signUp(user: User, success: @escaping () -> Void, failure: @escaping (APIError) -> Void) {
        
        let parameters = user.asParameters
        let avatar = UploadImage.init(key: "avatar", image: user.avatar)
        
        guard let request = RequestBuilder.POSTMultipartRequest(host: host, endpoint: .SignUp, parameters: parameters, image: avatar, token: nil)
            else {
                failure(.Error("Invalid POST request"))
                return }
        
        self.session.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                failure(.Error(error.localizedDescription))
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
                self.token = response["token"] as? String
                
                success()
                
            } else {
                failure(.Error("API response cannot be serialized"))
            }

            
        }.resume()
    }
    
    func signIn(withCredentials credentials: Credentials,  success: @escaping () -> Void, failure: @escaping (APIError) -> Void) {
        let parameters = credentials.asParameters
        
        guard let request = RequestBuilder.POSTMultipartRequest(host: host, endpoint: .SignIn, parameters: parameters, image: nil, token: nil)
            else {
                failure(.Error("Invalid POST request"))
                return }
        
        self.session.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                failure(.Error(error.localizedDescription))
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
                self.token = response["token"] as? String
                
                success()

            } else {
                failure(.Error("API response cannot be serialized"))
            }
            
        }.resume()
    }
    
    func loadPhotos(success: @escaping (JSONDictionary) -> Void, failure: @escaping (APIError) -> Void) {
        
        guard let token = token else {
            failure(.Error("No token access"))
            return
        }
        
        guard let request = RequestBuilder.GETRequest(host: host, endpoint: .All, token: token)
            else {
                failure(.Error("Invalid POST request"))
                return
        }
        
        self.session.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                failure(.Error(error.localizedDescription))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse,
                let responseError = APIError.init(code: httpResponse.statusCode) {
                failure(responseError)
                return
            }
            
            if let data = data,
                let json = try? JSONSerialization.jsonObject(with: data) {
                
                let rootDictionary = json as! JSONDictionary
                
                success(rootDictionary)
            }
            
        }.resume()
    }
    
    func executeRequest(url: String, success: @escaping (Data) -> Void, failure: @escaping (Error) -> Void) {
        
        guard let url = URL(string: url) else { return }
        
        session.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                DispatchQueue.main.async { failure(error) }
            }
            
            if let data = data {
                DispatchQueue.main.sync { success(data) }
            }
            
        }.resume()
    }
}
