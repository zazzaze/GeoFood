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
}

protocol MapInteractorOutputProtocol: class {
    func restaurantsLoadSuccessfully(restaurants: [RestaurantModel])
    func restaurantsLoadUnsuccessfully()
}

class MapInteractor: MapInteractorProtocol {
    private weak var presenter: MapInteractorOutputProtocol!
    private var service: RestaurantServiceProtocol
    
    required init(presenter: MapInteractorOutputProtocol, service: RestaurantServiceProtocol) {
        self.presenter = presenter
        self.service = service
    }
    
    func loadRestaurants(in region: CLLocationCoordinate2D, radius: Double) {
        let requestData = CoordinateRequestModel(coordinates: region, radius: radius)
        service.getRestaurantsNear(coordinate: requestData, token: "") { restaurants in
            guard let restaurants = restaurants else {
                self.presenter.restaurantsLoadUnsuccessfully()
                return
            }
            let group = DispatchGroup()
            let imageLoader = ImageLoader()
            for restaurant in restaurants {
                group.enter()
                DispatchQueue.global(qos: .utility).async {
                    imageLoader.loadImage(fileName: restaurant.shopLogoFileName) { data in
                        guard let data = data else {
                            group.leave()
                            return
                        }
                        restaurant.logo = UIImage(data: data)
                    }
                }
            }
            group.wait()
            self.presenter.restaurantsLoadSuccessfully(restaurants: restaurants)
        }
    }
}
