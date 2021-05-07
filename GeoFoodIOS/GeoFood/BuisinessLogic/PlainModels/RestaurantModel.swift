//
//  RestaurantModel.swift
//  GeoFood
//
//  Created by Егор on 25.03.2021.
//

import Foundation
import UIKit

/// Модель кафе
class RestaurantModel: Codable {
    /// id кафе
    var id: Int32
    /// Название кафе
    var name: String
    /// Долгота позиции кафе
    var longitude: Double
    /// Широта позиции кафе
    var latitude: Double
    /// Картинка кафе
    var logoImage: UIImage?
    /// Тип кафе
    var type: RestaurantType
    /// Адрес кафе
    var location: String
    /// Акции ресторана
    var sales: [RestaurantSaleModel]?
    
    /// Конструктор из модели кафе для CoreData
    /// - Parameter model: Модель кафе для CoreData
    init(from model: Restaurant) {
        id = model.id
        name = model.name
        longitude = model.longitude
        latitude = model.latitude
        type = model.type
        location = model.address
        sales = model.sales?.compactMap{ $0 as? RestaurantSaleModel }
    }
    
    /// Конструктор без параметров
    init() {
        id = 0
        name = "Test"
        longitude = 37.615
        latitude = 55.75222
        type = .coffee
        location = ""
    }
    
    /// Ключи для десериализации
    enum CodingKeys: CodingKey {
        case id
        case name
        case longitude
        case latitude
        case location
        case type
    }
}

/// Перечисление типов ресторана
@objc public enum RestaurantType: Int32, Codable {
    case coffee = 0
    case fastFood = 1
    
    /// Картинка для типа
    var image: UIImage {
        switch self {
        case .coffee:
            return UIImage(named: "coffee")!
        case .fastFood:
            return UIImage(named: "fast-food")!
        }
    }
    
    /// Текст названия типа
    var text: String {
        switch self {
        case .coffee:
            return "Кофе"
        case .fastFood:
            return "ФастФуд"
        }
    }
    
    /// Количество типов
    static let typesCount = 2
}
