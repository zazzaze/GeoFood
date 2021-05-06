//
//  RestaurantPresenter.swift
//  GeoFood
//
//  Created by Егор on 02.05.2021.
//

import Foundation

protocol RestaurantPresenterOutput: AnyObject {
    func configure(with vm: RestaurantViewModel)
}

class RestaurantPresenter {
    let currentRestaurant: RestaurantModel
    weak var view: RestaurantViewController!
    var interactor: RestaurantInteractorInput!
    init(with view: RestaurantViewController, currentRestaurant: RestaurantModel) {
        self.view = view
        self.currentRestaurant = currentRestaurant
    }
}

extension RestaurantPresenter: RestaurantViewControllerOutput {
    func viewDidLoad() {
        interactor.loadSales(for: currentRestaurant.id)
    }
}

extension RestaurantPresenter: RestaurantInteractorOutput {
    func loadedSales(_ sales: [RestaurantSaleModel]) {
        let viewModel = RestaurantViewModel(with: currentRestaurant, allSales: sales)
        DispatchQueue.main.async {
            self.view.configure(with: viewModel)
        }
    }
}




