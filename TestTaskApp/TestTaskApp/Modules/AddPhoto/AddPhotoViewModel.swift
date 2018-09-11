//
//  AddPhotoViewModel.swift
//  TestTaskApp
//
//  Created by Kate on 9/9/18.
//  Copyright © 2018 Kate. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class AddPhotoViewModel : NSObject, CLLocationManagerDelegate {
 
    let api: APIService
    var locationManager: CLLocationManager!
    var location: Location?
    
    var photo: Binding<UIImage>?
    var details = Binding<String>("")
    var tags = Binding<String>("")
    
    init(api: APIService) {
        self.api = api
    }
    
    func requestLocation() {
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.requestLocation()
        }
    }
    
    func createPhoto(success: @escaping () -> Void, failure: @escaping (String) -> Void) {
        
        guard let photo = photo?.value else { return }
        guard let image = UploadPhoto(image: photo, details: details.value, tags: tags.value, location: location) else { return }
        
        api.createPhoto(photo: image, success: {
            
            DispatchQueue.main.async {
                success()
            }
            
        }) { (error) in
            
            switch error {
            case .Error(let result):
                
                DispatchQueue.main.async {
                    failure(result)
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let lastLocation = locations.last {
            let coordinate = lastLocation.coordinate
            location = Location(latitude: coordinate.latitude, longitude: coordinate.longitude )
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
}

