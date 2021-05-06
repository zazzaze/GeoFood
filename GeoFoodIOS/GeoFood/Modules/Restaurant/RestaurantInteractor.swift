//
//  RestaurantInteractor.swift
//  GeoFood
//
//  Created by Егор on 04.05.2021.
//

import Foundation
import UIKit

protocol RestaurantInteractorInput: AnyObject {
    func loadSales(for restId: Int32)
}

protocol RestaurantInteractorOutput: AnyObject {
    func loadedSales(_ sales: [RestaurantSaleModel])
}

class RestaurantInteractor: RestaurantInteractorInput {
    let userService = UserService.shared
    weak var output: RestaurantInteractorOutput!
    
    init(with output: RestaurantInteractorOutput) {
        self.output = output
    }
    
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
