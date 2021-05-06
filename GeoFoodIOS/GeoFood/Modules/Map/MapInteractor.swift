//
//  MapInteractor.swift
//  GeoFood
//
//  Created by Егор on 26.03.2021.
//

import Foundation
import MapKit

protocol MapInteractorInput: class {
    func loadRestaurants(in region: CLLocationCoordinate2D, radius: Double)
    func sendUserLocationUpdate(_ location: CLLocation)
}

protocol MapInteractorOutput: class {
    func restaurantsLoad(restaurants: [RestaurantModel])
}

class MapInteractor {
    private weak var presenter: MapInteractorOutput!
    private var service: UserService
    private var token: String!
    
    required init(presenter: MapInteractorOutput, service: UserService) {
        self.presenter = presenter
        self.service = service
    }
}

extension MapInteractor: MapInteractorInput {
    func loadRestaurants(in region: CLLocationCoordinate2D, radius: Double) {
        let requestData = CoordinateRequestModel(coordinates: region, radius: radius)
        service.getRestaurantsNear(coordinate: requestData) { restaurants in
            guard let restaurants = restaurants else {
                self.presenter.restaurantsLoad(restaurants: [])
                return
            }
            let group = DispatchGroup()
            for rest in restaurants {
                group.enter()
                ImageLoader.loadRestaurantImage(restId: rest.id) { data in
                    if let data = data {
                        rest.logoImage = UIImage(data: data)
                    } else {
                        rest.logoImage = UIImage(named: "empty")
                    }
                    group.leave()
                }
            }
            group.notify(queue: DispatchQueue.global(qos: .utility), work: DispatchWorkItem {
                self.presenter.restaurantsLoad(restaurants: restaurants)
            })
        }
    }
    
    func sendUserLocationUpdate(_ location: CLLocation) {
        service.updateUserLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
    }
}
