//
//  GifViewController.swift
//  TestTaskApp
//
//  Created by Kate on 9/11/18.
//  Copyright © 2018 Kate. All rights reserved.
//

import Foundation
import UIKit

class GifViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    
    var gifURL: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = gifURL {
            let request = URLRequest(url: url)
            webView.loadRequest(request)
        }
    }
    
    func configurePopover(sourceView: UIView?) {
        
        self.modalPresentationStyle = .popover
        self.preferredContentSize = CGSize(width: 350, height: 350)
        let presentationController = self.presentationController as! UIPopoverPresentationController
        presentationController.sourceView = sourceView
        presentationController.sourceRect = CGRect(x: 260, y: 40, width: 150, height: 0)
        presentationController.delegate = self
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}

