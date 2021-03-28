//
//  RestaurantModel.swift
//  GeoFood
//
//  Created by Егор on 25.03.2021.
//

import Foundation
import UIKit

class RestaurantModel: Codable {
    var id: UUID
    var name: String
    var longitude: Double
    var latitude: Double
    var shopLogoFileName: String
    var logo: UIImage?
    
    init() {
        id = UUID()
        name = "Test"
        longitude = 0
        latitude = 0
        shopLogoFileName = "Test"
    }
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case longitude
        case latitude
        case shopLogoFileName
    }
}
