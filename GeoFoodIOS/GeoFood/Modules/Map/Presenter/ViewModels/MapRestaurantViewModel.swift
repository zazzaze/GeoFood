//
//  MapRestaurantModel.swift
//  GeoFood
//
//  Created by Егор on 01.05.2021.
//

import Foundation
import MapKit

class MapRestaurantViewModel {
    let id: Int32
    let image: UIImage
    let annotation: MKPointAnnotation = MKPointAnnotation()
    let type: RestaurantType
    
    init(with model: RestaurantModel) {
        image = model.logoImage ?? UIImage(named: "empty")!
        id = model.id
        annotation.coordinate = CLLocationCoordinate2D(latitude: model.latitude, longitude: model.longitude)
        self.type = model.type
    }
}
