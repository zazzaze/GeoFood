//
//  MapRouter.swift
//  GeoFood
//
//  Created by Егор on 26.03.2021.
//

import Foundation
import UIKit

protocol MapRouterProtocol: class {
    func openRestaurantView(with restaurant: RestaurantModel, token: String)
}

class MapRouter: MapRouterProtocol {
    private var view: MapViewController
    
    required init(view: MapViewController) {
        self.view = view
    }
    
    func openRestaurantView(with restaurant: RestaurantModel, token: String) {
        view.present(UINavigationController(rootViewController: RestaurantConfigurator.assembly(with: restaurant)), animated: true, completion: nil)
    }
}
