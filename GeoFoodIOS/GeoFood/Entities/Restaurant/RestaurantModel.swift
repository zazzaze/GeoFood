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
    var shopLogoFileName: String
    var description: String?
    var logo: UIImage?
    
    init() {
        id = 0
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
        case description
    }
}
