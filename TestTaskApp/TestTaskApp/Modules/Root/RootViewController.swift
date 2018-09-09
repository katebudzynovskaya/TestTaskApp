//
//  RootViewController.swift
//  TestTaskApp
//
//  Created by Kate on 9/9/18.
//  Copyright © 2018 Kate. All rights reserved.
//

import Foundation
import UIKit

class RootViewController: UIViewController {

    var api: APIService!
    
    // property for image cache
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.api = APIService()
        // init image cache
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        start()
    }
    
    func start() {
        startAuthorizationFlow()
    }
    
    func startAuthorizationFlow() {

        let startViewController = storyboard?.instantiateViewController(withIdentifier: "StartViewController") as? StartViewController
        
        guard let startVC = startViewController else { return }
        
        startVC.api = api
        startVC.athorizationDidFinish = {
            self.navigationController?.popViewController(animated: false)
            self.openPhotoList()
        }
        
        self.navigationController?.pushViewController(startVC, animated: false)
    }
    
    func openPhotoList() {
        
        let photoListController = storyboard?.instantiateViewController(withIdentifier: "PhotoListViewController") as? PhotoListViewController
        
        guard let photoListVC = photoListController else { return }
        // init view model with api and cache and set
        
        self.navigationController?.pushViewController(photoListVC, animated: false)
    }
}
