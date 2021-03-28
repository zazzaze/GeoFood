//
//  CoordinateRequestModel.swift
//  GeoFood
//
//  Created by Егор on 26.03.2021.
//

import Foundation
import MapKit

struct CoordinateRequestModel: Codable {
    let longitude: Double
    let latitude: Double
    let radius: Double
    
    init(coordinates: CLLocationCoordinate2D, radius: Double) {
        longitude = coordinates.longitude
        latitude = coordinates.latitude
        self.radius = radius
    }
}
