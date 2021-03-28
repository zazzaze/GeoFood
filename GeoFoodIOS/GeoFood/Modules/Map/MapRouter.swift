//
//  MapRouter.swift
//  GeoFood
//
//  Created by Егор on 26.03.2021.
//

import Foundation

protocol MapRouterProtocol: class {
    func openRestaurantView(with restaurant: RestaurantModel)
}

class MapRouter: MapRouterProtocol {
    private var view: MapViewController
    
    required init(view: MapViewController) {
        self.view = view
    }
    
    func openRestaurantView(with restaurant: RestaurantModel) {
        view.present(RestaurantViewController(restaurant: restaurant), animated: true, completion: nil)
    }
}
