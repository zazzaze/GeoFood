//
//  MapModel.swift
//  GeoFood
//
//  Created by Егор on 01.05.2021.
//

import Foundation

/// Модель представления карты
class MapViewModel {
    /// Кафе, которые необходимо добавить на карту
    var mapRestaurants: [MapRestaurantViewModel] = []
    /// Кафе, которые необходимо удалить с карты
    var deletedRestaurants: [MapRestaurantViewModel] = []
    /// Все кафе
    var allRests: [MapRestaurantViewModel] = []
    /// Необходимо ли удалить все кафе с карта
    var deleteAll = false
    
    /// Конструктор слияния старой модели с новыми кафе
    /// - Parameters:
    ///   - restaurants: Новые кафе
    ///   - oldModel: Старая модель
    init(with restaurants: [RestaurantModel], oldModel: MapViewModel?) {
        if let oldModel = oldModel {
            if restaurants.count == 0 {
                deleteAll = true
                return
            }
            deletedRestaurants = oldModel.mapRestaurants.filter { old in !restaurants.contains(where: { old.id == $0.id }) }
            for rest in restaurants {
                if let oldRest = oldModel.allRests.first(where: { $0.id == rest.id }) {
                    allRests.append(oldRest)
                } else {
                    allRests.append(MapRestaurantViewModel(with: rest))
                }
            }
            mapRestaurants = allRests.filter{ rest in !oldModel.mapRestaurants.contains(where: { rest.id == $0.id }) }
        } else {
            allRests = restaurants.map{ MapRestaurantViewModel(with: $0) }
            mapRestaurants = allRests
        }
    }
    
    /// Обновить кафе по фильтру
    /// - Parameter types: Типы кафе для фильтрации
    func updateForTypes(_ types: [RestaurantType]) {
        mapRestaurants = allRests.filter{ types.count == 0 || types.contains($0.type) }
        deletedRestaurants = allRests.filter{ !types.contains($0.type) && types.count != 0 }
    }
}
