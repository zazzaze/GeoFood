//
//  RestaurantInteractor.swift
//  GeoFood
//
//  Created by Егор on 04.05.2021.
//

import Foundation
import UIKit

/// Входные методы интерактора
protocol RestaurantInteractorInput: AnyObject {
    /// Загрузить акции кафе
    /// - Parameter restId: id кафе
    func loadSales(for restId: Int32)
}

/// Выходные методы интерактора
protocol RestaurantInteractorOutput: AnyObject {
    /// Акции, загруженные из сети
    /// - Parameter sales: Массив загруженных акций
    func loadedSales(_ sales: [RestaurantSaleModel])
}

class RestaurantInteractor: RestaurantInteractorInput {
    /// Сервис пользователя
    let userService = UserService.shared
    /// Презентер кафе
    weak var output: RestaurantInteractorOutput!
    
    /// Конструктор
    /// - Parameter output: Презентер кафе
    init(with output: RestaurantInteractorOutput) {
        self.output = output
    }
    
    /// Загрузить акции
    /// - Parameter restId: id кафеы
    func loadSales(for restId: Int32) {
        self.userService.getRestaurantSales(restaurantId: restId){ sales in
            guard let sales = sales else {
                self.output.loadedSales([])
                return
            }
            let group = DispatchGroup()
            for sale in sales {
                group.enter()
                ImageLoader.loadSaleImage(saleId: sale.id) { data in
                    if let data = data {
                        sale.image = UIImage(data: data)
                    } else {
                        sale.image = UIImage(named: "empty")
                    }
                    group.leave()
                }
            }
            group.notify(queue: DispatchQueue.global(qos: .utility), work: DispatchWorkItem {
                self.output.loadedSales(sales)
            })
        }
    }
}
