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
    var cityArray: [Country] = [Country]()
    
    //
    // MARK: - Init
    init() {
        // Init variables
    }
    
    //
    // MARK: - Functions
    
//    /// Geocoder of a string to CLPlacemark
//    ///
//    /// - Parameters:
//    ///   - string: String
//    ///   - completion: Closure
//    func geocode(of string: String, completion: @escaping () -> Void, failure: @escaping () -> Void ) {
//        geocoder.geocodeAddressString(string) { (placemarks, error) in
//            if let error = error {
//                print("Unable to Forward Geocode Address (\(error))")
//                self.cityArray.removeAll()
//                failure()
//            }
//            
//            if let placemarks = placemarks, placemarks.count > 0 {
//                self.cityArray = placemarks
//            }
//            completion()
//        }
//    }
    
    func searchCountry(name: String) {
        self.cityArray = CountryHelper.countries.filter { $0.name.lowercased().contains(name.lowercased()) }
    }
}
