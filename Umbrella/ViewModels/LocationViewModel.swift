//
//  LocationViewModel.swift
//  Umbrella
//
//  Created by Lucas Correa on 11/09/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import CoreLocation

class LocationViewModel {
    
    //
    // MARK: - Properties
    lazy var geocoder = CLGeocoder()
    var cityArray: [CLPlacemark] = [CLPlacemark]()
    
    //
    // MARK: - Init
    init() {
        
    }
    
    func geocode(of string: String, completion: @escaping () -> Void ) {
        geocoder.geocodeAddressString(string) { (placemarks, error) in
            if let error = error {
                print("Unable to Forward Geocode Address (\(error))")
                self.cityArray.removeAll()
            }
            
            if let placemarks = placemarks, placemarks.count > 0 {
                self.cityArray = placemarks
            }
            completion()
        }
    }
}
