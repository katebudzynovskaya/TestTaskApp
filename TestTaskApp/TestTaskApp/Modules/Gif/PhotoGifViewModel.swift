//
//  PhotoGifViewModel.swift
//  TestTaskApp
//
//  Created by Kate on 9/9/18.
//  Copyright © 2018 Kate. All rights reserved.
//

import Foundation

class PhotoGifViewModel {
    
    let api: APIService
    
    init(api: APIService) {
        self.api = api
    }
    
    func getGif(success: @escaping (URL) -> Void, failure: @escaping (String) -> (Void)){
        
        api.loadGif(success: { (url) in
            
            DispatchQueue.main.async {
                success(url)
            }
            
        }) {(error) in
            
            switch error {
            case .Error(let result):
                
                DispatchQueue.main.async {
                    failure(result)
                }
            }
        }
    }
}
