//
//  RestaurantPresenter.swift
//  GeoFood
//
//  Created by Егор on 02.05.2021.
//

import Foundation

/// Выходные данные презентера кафе
protocol RestaurantPresenterOutput: AnyObject {
    func configure(with vm: RestaurantViewModel)
}

/// Презентер кафе
class RestaurantPresenter {
    /// Текущее кафе
    let currentRestaurant: RestaurantModel
    /// Контроллер кафе
    weak var view: RestaurantViewController!
    /// Интерактор кафе
    var interactor: RestaurantInteractorInput!
    /// Конструктор
    /// - Parameters:
    ///   - view: Контроллер кафе
    ///   - currentRestaurant: Текущее кафе
    init(with view: RestaurantViewController, currentRestaurant: RestaurantModel) {
        self.view = view
        self.currentRestaurant = currentRestaurant
    }
}

extension RestaurantPresenter: RestaurantViewControllerOutput {
    /// Контроллер загрузился
    func viewDidLoad() {
        interactor.loadSales(for: currentRestaurant.id)
    }
}

extension RestaurantPresenter: RestaurantInteractorOutput {
    /// Акции кафе загружены
    /// - Parameter sales: Массив загруженных акций
    func loadedSales(_ sales: [RestaurantSaleModel]) {
        let viewModel = RestaurantViewModel(with: currentRestaurant, allSales: sales)
        DispatchQueue.main.async {
            self.view.configure(with: viewModel)
        }
    }
}




