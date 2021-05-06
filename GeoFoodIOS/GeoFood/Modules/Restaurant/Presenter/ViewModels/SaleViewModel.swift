//
//  SaleViewModel.swift
//  GeoFood
//
//  Created by Егор on 24.04.2021.
//

import Foundation
import UIKit

class SaleViewModel {
    let name: String
    let price: String
    let code: String
    let image: UIImage
    
    init(with model: RestaurantSaleModel) {
        name = model.name
        price = "\(model.newPrice)\u{20BD}"
        code = "Промокод: \(model.promo ?? "F2C4")"
        image = model.image ?? UIImage(named: "empty")!
    }
}
