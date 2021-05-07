//
//  MapInteractor.swift
//  GeoFood
//
//  Created by Егор on 26.03.2021.
//

import Foundation
import MapKit

/// Входные методы интеракторы карты
protocol MapInteractorInput: class {
    /// Загрузить кафе
    /// - Parameters:
    ///   - region: Отображаемый регион
    ///   - radius: Радиус отображения
    func loadRestaurants(in region: CLLocationCoordinate2D, radius: Double)
    /// Отправить изменение позиции пользователя
    /// - Parameter location: Позиция пользователя
    func sendUserLocationUpdate(_ location: CLLocation)
}

/// Выходные методы интерактора
protocol MapInteractorOutput: class {
    /// Кафе загружены
    /// - Parameter restaurants: Массив загруженных кафе
    func restaurantsLoad(restaurants: [RestaurantModel])
}

class MapInteractor {
    /// Презентер карты
    private weak var presenter: MapInteractorOutput!
    /// Сервис пользователя
    private var service: UserService
    
    /// Конструктор
    /// - Parameters:
    ///   - presenter: Презентер карты
    ///   - service: Сервис пользователя
    required init(presenter: MapInteractorOutput, service: UserService) {
        self.presenter = presenter
        self.service = service
    }
}

extension MapInteractor: MapInteractorInput {
    /// Загрузить кафе
    /// - Parameters:
    ///   - region: Отображаемый регион
    ///   - radius: Радиус отображения
    func loadRestaurants(in region: CLLocationCoordinate2D, radius: Double) {
        let requestData = CoordinateRequestModel(coordinates: region, radius: radius)
        service.getRestaurantsNear(coordinate: requestData) { restaurants in
            guard let restaurants = restaurants else {
                self.presenter.restaurantsLoad(restaurants: [])
                return
            }
            let group = DispatchGroup()
            for rest in restaurants {
                group.enter()
                ImageLoader.loadRestaurantImage(restId: rest.id) { data in
                    if let data = data {
                        rest.logoImage = UIImage(data: data)
                    } else {
                        rest.logoImage = UIImage(named: "empty")
                    }
                    group.leave()
                }
            }
            group.notify(queue: DispatchQueue.global(qos: .utility), work: DispatchWorkItem {
                self.presenter.restaurantsLoad(restaurants: restaurants)
            })
        }
    }
    
    /// Отправить изменение позиции пользователя
    /// - Parameter location: Позиция пользователя
    func sendUserLocationUpdate(_ location: CLLocation) {
        service.updateUserLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
    }
}
