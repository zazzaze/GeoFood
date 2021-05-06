//
//  MapPresenter.swift
//  GeoFood
//
//  Created by Егор on 17.03.2021.
//

import Foundation
import MapKit

protocol MapPresenterInput: class {
    func regionDidChange(region: MKCoordinateRegion, radius: Double)
    func createAnnotationView(for annotation: MKAnnotation) -> RestaurantAnnotation?
    func annotationTapped(_ annotation: MKAnnotationView)
    func updateUserLocation(_ locations: [CLLocation])
    func changeFilter(for index: Int, state: Bool)
    func viewDidAppear()
}

class MapPresenter: MapPresenterInput {
    private var lastLocation: CLLocation?
    private var filterTypes: [RestaurantType] = []
    private weak var view: MapViewInput!
    var interactor: MapInteractorInput!
    var router: MapRouterProtocol!
    var restaurants: [RestaurantModel]  = []
    private var token: String!
    private var currentViewModel: MapViewModel?
    private var lastRegion: MKCoordinateRegion?
    
    required init(view: MapViewController) {
        self.view = view
    }
    
    func regionDidChange(region: MKCoordinateRegion, radius: Double) {
        if let lastRegion = lastRegion {
            let lastLocation = CLLocation(latitude: lastRegion.center.latitude, longitude: lastRegion.center.longitude)
            let currentLocation = CLLocation(latitude: region.center.latitude, longitude: region.center.longitude)
            if  lastLocation.distance(from: currentLocation).isLessThanOrEqualTo(100) {
                return
            }
        }
        lastRegion = region
        self.interactor.loadRestaurants(in: region.center, radius: radius)
    }
    
    func createAnnotationView(for annotation: MKAnnotation) -> RestaurantAnnotation? {
        return nil
    }
    
    func annotationTapped(_ annotation: MKAnnotationView) {
        guard let restAnnotation = annotation as? RestaurantAnnotation,
              let restaurant = self.restaurants.first(where: { $0.id == restAnnotation.restaurant.id })
        else {
            return
        }
        
        self.router.openRestaurantView(with: restaurant, token: "")
    }
    
    func updateUserLocation(_ locations: [CLLocation]) {
        guard let newLocation = locations.last else {
            return
        }
        if let lastLocation = lastLocation {
            if lastLocation.distance(from: newLocation).isLessThanOrEqualTo(100) {
                return
            }
            self.lastLocation = newLocation
        } else {
            self.lastLocation = newLocation
        }
        self.interactor.sendUserLocationUpdate(lastLocation!)
    }
    
    func changeFilter(for index: Int, state: Bool) {
        if state {
            addFilter(for: index)
        } else {
            removeFilter(for: index)
        }
    }
    
    private func addFilter(for index: Int) {
        guard let newFilter = RestaurantType(rawValue: Int32(index)) else {
            return
        }
        filterTypes.append(newFilter)
        guard let currentViewModel = currentViewModel else {
            return
        }
        currentViewModel.updateForTypes(filterTypes)
        self.view.configure(with: currentViewModel)
    }
    
    private func removeFilter(for index: Int) {
        filterTypes.removeAll(where: { $0.rawValue == Int32(index) })
        guard let currentViewModel = currentViewModel else {
            return
        }
        currentViewModel.updateForTypes(filterTypes)
        self.view.configure(with: currentViewModel)
    }
    
    func viewDidAppear() {
        guard let coordinate = LocationManager.shared.location else {
            return
        }
        interactor.loadRestaurants(in: coordinate.coordinate, radius: 1000)
    }
}

extension MapPresenter: MapInteractorOutput {
    func restaurantsLoad(restaurants: [RestaurantModel]) {
        self.restaurants = restaurants
        let mapVM = MapViewModel(with: self.restaurants, oldModel: self.currentViewModel)
        mapVM.updateForTypes(filterTypes)
        self.currentViewModel = mapVM
        DispatchQueue.main.async {
            self.view.configure(with: mapVM)
        }
    }
    
}
