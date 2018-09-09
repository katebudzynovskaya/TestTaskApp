//
//  BindingType.swift
//  TestTaskApp
//
//  Created by Kate on 9/9/18.
//  Copyright © 2018 Kate. All rights reserved.
//

import Foundation

class Binding<T> {
    
    var bind :(T) -> () = { _ in }
    
    var value :T? {
        didSet {
            bind(value!)
        }
    }
    
    init(_ v :T) {
        value = v
    }
    
    init?(_ v : T?) {
        guard let v = v else { return nil }
        value = v
    }
    
}
