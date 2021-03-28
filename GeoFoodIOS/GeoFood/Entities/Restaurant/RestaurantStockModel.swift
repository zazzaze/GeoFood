//
//  RestaurantStockModel.swift
//  GeoFood
//
//  Created by Егор on 25.03.2021.
//

import Foundation
import UIKit

class RestaurantStockModel: Codable {
    var name: String
    var description: String
    var stockImageFileName: String
    var defaultPrice: Double
    var currentPrice: Double
    var image: UIImage?
    
    enum CodingKeys: CodingKey {
        case name
        case description
        case stockImageFileName
        case defaultPrice
        case currentPrice
    }
}
