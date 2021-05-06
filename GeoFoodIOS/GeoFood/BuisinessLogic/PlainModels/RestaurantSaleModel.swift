//
//  RestaurantStockModel.swift
//  GeoFood
//
//  Created by Егор on 25.03.2021.
//

import Foundation
import UIKit

class RestaurantSaleModel: Codable {
    var id: Int32
    var name: String
    var promo: String?
    var image: UIImage?
    var oldPrice: Int32?
    var newPrice: Int32
    var special: Bool
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case promo
        case oldPrice
        case newPrice
        case special
    }
    
    init() {
        id = 0
        name = "Test"
        promo = "Test"
        oldPrice = 200
        newPrice = 300
        special = false
    }
    
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
