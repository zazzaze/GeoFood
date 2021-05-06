//
//  RestaurantModel.swift
//  GeoFood
//
//  Created by Егор on 25.03.2021.
//

import Foundation
import UIKit

class RestaurantModel: Codable {
    var id: Int32
    var name: String
    var longitude: Double
    var latitude: Double
    var logoImage: UIImage?
    var type: RestaurantType
    var location: String
    var sales: [RestaurantSaleModel]?
    
    init(from model: Restaurant) {
        id = model.id
        name = model.name
        longitude = model.longitude
        latitude = model.latitude
        type = model.type
        location = model.address
        sales = model.sales?.compactMap{ $0 as? RestaurantSaleModel }
    }
    
    init() {
        id = 0
        name = "Test"
        longitude = 37.615
        latitude = 55.75222
        type = .coffee
        location = ""
    }
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case longitude
        case latitude
        case location
        case type
    }
}

@objc public enum RestaurantType: Int32, Codable {
    case coffee = 0
    case fastFood = 1
    
    var image: UIImage {
        switch self {
        case .coffee:
            return UIImage(named: "coffee")!
        case .fastFood:
            return UIImage(named: "fast-food")!
        }
    }

    var text: String {
        switch self {
        case .coffee:
            return "Кофе"
        case .fastFood:
            return "ФастФуд"
        }
    }
    
    static let typesCount = 2
}
