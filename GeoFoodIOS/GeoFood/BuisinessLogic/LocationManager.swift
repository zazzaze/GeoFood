//
//  LocationManager.swift
//  GeoFood
//
//  Created by Егор on 05.05.2021.
//

import Foundation
import MapKit

final class LocationManager: CLLocationManager {
    static let shared = LocationManager()
    
    func userDistance(to location: CLLocation) -> Double {
        return self.location?.distance(from: location) ?? 0
    }
}
