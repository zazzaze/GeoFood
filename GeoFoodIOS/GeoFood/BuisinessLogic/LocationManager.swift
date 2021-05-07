//
//  LocationManager.swift
//  GeoFood
//
//  Created by Егор on 05.05.2021.
//

import Foundation
import MapKit

/// Сервис позиции пользователя
final class LocationManager: CLLocationManager {
    /// Общий объект сервиса
    static let shared = LocationManager()
    
    /// Расстояние от позиции пользователя до геоточки
    /// - Parameter location: Геоточка
    /// - Returns: Расстояние
    func userDistance(to location: CLLocation) -> Double {
        return self.location?.distance(from: location) ?? 0
    }
}
