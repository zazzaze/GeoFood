//
//  MapRouter.swift
//  GeoFood
//
//  Created by Егор on 26.03.2021.
//

import Foundation
import UIKit

/// Протокол роутера карты
protocol MapRouterProtocol: class {
    /// Открыть модуль кафе
    /// - Parameters:
    ///   - restaurant: Кафе для модуля
    func openRestaurantView(with restaurant: RestaurantModel)
}

/// Роутер карты
class MapRouter: MapRouterProtocol {
    /// Контроллер карты
    private var view: MapViewController
    
    /// Конструктор
    /// - Parameter view: Контроллер карты
    required init(view: MapViewController) {
        self.view = view
    }
    
    /// Открыть модуль кафе
    /// - Parameters:
    ///   - restaurant: Кафе для модуля
    func openRestaurantView(with restaurant: RestaurantModel) {
        view.present(UINavigationController(rootViewController: RestaurantConfigurator.assembly(with: restaurant)), animated: true, completion: nil)
    }
}
