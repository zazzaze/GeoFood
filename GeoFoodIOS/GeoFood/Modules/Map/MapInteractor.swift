//
//  MapInteractor.swift
//  GeoFood
//
//  Created by Егор on 26.03.2021.
//

import Foundation
import MapKit

protocol MapInteractorProtocol: class {
    func loadRestaurants(in region: CLLocationCoordinate2D, radius: Double)
    func setToken(_ token: String)
}

protocol MapInteractorOutputProtocol: class {
    func restaurantsLoadSuccessfully(restaurants: [RestaurantModel])
    func restaurantsLoadUnsuccessfully()
}

class MapInteractor: MapInteractorProtocol {
    private weak var presenter: MapInteractorOutputProtocol!
    private var service: RestaurantServiceProtocol
    private var token: String!
    
    required init(presenter: MapInteractorOutputProtocol, service: RestaurantServiceProtocol) {
        self.presenter = presenter
        self.service = service
    }
    
    func setToken(_ token: String) {
        self.token = token
    }
    
    func loadRestaurants(in region: CLLocationCoordinate2D, radius: Double) {
        let requestData = CoordinateRequestModel(coordinates: region, radius: radius)
        service.getRestaurantsNear(coordinate: requestData, token: token) { restaurants in
            guard let restaurants = restaurants else {
                self.presenter.restaurantsLoadUnsuccessfully()
                return
            }
            self.presenter.restaurantsLoadSuccessfully(restaurants: restaurants)
        }
    }
}
