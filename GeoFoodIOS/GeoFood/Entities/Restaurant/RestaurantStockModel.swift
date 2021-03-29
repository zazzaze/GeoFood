//
//  RestaurantStockModel.swift
//  GeoFood
//
//  Created by Егор on 25.03.2021.
//

import Foundation
import UIKit

class RestaurantStockModel: Codable {
    var id: Int32
    var name: String
    var description: String?
    var stockImageFileName: String?
    var oldPrice: Int32
    var newPrice: Int32
    var image: UIImage?
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case description
        case stockImageFileName
        case oldPrice
        case newPrice
    }
}
