//
//  CoordinateRequestModel.swift
//  GeoFood
//
//  Created by Егор on 26.03.2021.
//

import Foundation
import MapKit

/// Модель данных для запроса кафе в окружности в центре геоточки и радиусе
struct CoordinateRequestModel: Codable {
    /// Долгота точки
    let longitude: Double
    /// Широта точки
    let latitude: Double
    /// Радиус поиска
    let radius: Double
    
    /// Конструктор
    /// - Parameters:
    ///   - coordinates: Координаты геоточки
    ///   - radius: Радиус поиска
    init(coordinates: CLLocationCoordinate2D, radius: Double) {
        longitude = coordinates.longitude
        latitude = coordinates.latitude
        self.radius = radius
    }
}
