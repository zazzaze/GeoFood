//
//  SaleViewModel.swift
//  GeoFood
//
//  Created by Егор on 24.04.2021.
//

import Foundation
import UIKit

/// Модель представления данных акции
class SaleViewModel {
    /// Имя акции
    let name: String
    /// Цена акции
    let price: String
    /// Промокод акции
    let code: String
    /// Картинка акции
    let image: UIImage
    
    /// Конструктор из модели акции
    /// - Parameter model: Модель акции
    init(with model: RestaurantSaleModel) {
        name = model.name
        price = "\(model.newPrice)\u{20BD}"
        code = "Промокод: \(model.promo ?? "F2C4")"
        image = model.image ?? UIImage(named: "empty")!
    }
}
