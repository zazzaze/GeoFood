//
//  LocationManager.swift
//  GeoFoodIOS
//
//  Created by Егор on 16.01.2021.
//

import Foundation
import MapKit
import SwiftUI

class LocationManager: NSObject{
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation? = nil
    
    override init(){
        super.init()
        self.locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        self.location = location
    }
    
}
