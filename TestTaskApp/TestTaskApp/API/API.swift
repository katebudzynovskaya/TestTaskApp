//
//  API.swift
//  TestTaskApp
//
//  Created by Kate on 9/8/18.
//  Copyright © 2018 Kate. All rights reserved.
//

import Foundation

enum Endpoint : String {
    
    case SignUp = "/create"
    case SignIn = "/login"
    
    case Image = "/image"
    case All = "/all"
    case Gif = "/gif"
}

enum HttpMethod : String {
    case GET = "GET"
    case POST = "POST"
}

enum MimeType : String {
    
    case ImagePNG = "image/png"
    case ImageJPEG = "image/jpeg"
}

typealias Parameters = [String: String]

protocol Parameterized {
    var asParameters: Parameters {get}
}

typealias JSONDictionary = [String: Any]

enum APIError : Error {
    
    case InvalidRequestError(String)
    case IncorrectRequestError(String)
    case InvalidAccessToken(String)
    case SignUpError(String)
    case SignInError(String)
    case SerializationError(String)
    case UnknownError(String)
    
    init?(code: Int) {
        switch code {
        case 400:
            self = .IncorrectRequestError("Incorrect request data error")
        case 403:
            self = .InvalidAccessToken("Invalid access token")
        default: return nil
        }
    }
}

protocol API {
        
    func signUp(user: User, success: @escaping (Data) -> Void, failure: @escaping (APIError) -> Void)
    func signIn(withCredentials credentials: Credentials,  success: @escaping (Data) -> Void, failure: @escaping (APIError) -> Void)

}
