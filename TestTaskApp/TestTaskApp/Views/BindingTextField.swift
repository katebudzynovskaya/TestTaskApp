//
//  BindingTextField.swift
//  TestTaskApp
//
//  Created by Kate on 9/9/18.
//  Copyright © 2018 Kate. All rights reserved.
//

import Foundation
import UIKit

class BindingTextField : UITextField {
    
    var textDidChange: (String) -> Void = { _ in}

    func bind(callback: @escaping (String) -> Void) {
        
        self.textDidChange = callback
        self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.textDidChange(textField.text!)
    }
}
