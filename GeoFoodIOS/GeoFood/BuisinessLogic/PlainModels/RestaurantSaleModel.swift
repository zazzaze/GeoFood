//
//  RestaurantStockModel.swift
//  GeoFood
//
//  Created by Егор on 25.03.2021.
//

import Foundation
import UIKit

/// Модель акции кафе
class RestaurantSaleModel: Codable {
    /// id акции
    var id: Int32
    /// Название акции
    var name: String
    /// Промокод акции
    var promo: String?
    /// Картинка акции
    var image: UIImage?
    /// Изначальная цена товара
    var oldPrice: Int32?
    /// Новая цена по акции
    var newPrice: Int32
    /// Является ли акция специальной
    var special: Bool
    
    /// Ключи для парсинга
    enum CodingKeys: CodingKey {
        case id
        case name
        case promo
        case oldPrice
        case newPrice
        case special
    }
    
    /// Конструктор класса
    init() {
        id = 0
        name = "Test"
        promo = "Test"
        oldPrice = 200
        newPrice = 300
        special = false
    }
    
    /// Конструктор из модели акции для CoreData
    /// - Parameter model: Модель акции для CoreData
    init(from model: Sale) {
        self.id = model.id
        self.name = model.name
        self.promo = model.code
        self.newPrice = model.price
        self.special = model.isSpecial
        if let data = model.image {
            self.image = UIImage(data: data)
        } else {
            self.image = UIImage(named: "empty")
        }
    }
}
