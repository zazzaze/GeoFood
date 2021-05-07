//
//  MapRestaurantModel.swift
//  GeoFood
//
//  Created by Егор on 01.05.2021.
//

import Foundation
import MapKit

/// Модель представления кафе на карте
class MapRestaurantViewModel {
    /// id кафе
    let id: Int32
    /// Картинка кафе
    let image: UIImage
    /// Аннотация кафе
    let annotation: MKPointAnnotation = MKPointAnnotation()
    /// Тип кафе
    let type: RestaurantType
    
    /// Конструктор из модели кафе
    /// - Parameter model: Модель кафе
    init(with model: RestaurantModel) {
        image = model.logoImage ?? UIImage(named: "empty")!
        id = model.id
        annotation.coordinate = CLLocationCoordinate2D(latitude: model.latitude, longitude: model.longitude)
        self.type = model.type
    }
}
