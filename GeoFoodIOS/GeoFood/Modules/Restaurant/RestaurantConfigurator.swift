//
//  RestaurantConfigurator.swift
//  GeoFood
//
//  Created by Егор on 04.05.2021.
//

import Foundation

class RestaurantConfigurator {
    static func assembly(with restaurant: RestaurantModel) -> RestaurantViewController {
        let view = RestaurantViewController()
        let presenter = RestaurantPresenter(with: view, currentRestaurant: restaurant)
        view.presenter = presenter
        let interactor = RestaurantInteractor(with: presenter)
        presenter.interactor = interactor
        
        return view
    }
}
