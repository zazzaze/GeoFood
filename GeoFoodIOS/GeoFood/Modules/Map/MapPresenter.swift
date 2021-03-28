//
//  MapPresenter.swift
//  GeoFood
//
//  Created by Егор on 17.03.2021.
//

import Foundation
import MapKit

protocol MapPresenterProtocol: class {
    func regionDidChange(region: MKCoordinateRegion, radius: Double)
    func createAnnotationView(for annotation: MKAnnotation) -> RestaurantAnnotation?
    func annotationTapped(_ annotation: MKAnnotationView)
}

class MapPresenter: MapPresenterProtocol {
    
    private weak var view: MapViewController!
    var interactor: MapInteractorProtocol!
    var router: MapRouterProtocol!
    var restaurants: [RestaurantModel]  = [] {
        didSet {
            addAnnotations()
        }
    }
    
    required init(view: MapViewController) {
        self.view = view
    }
    
    func regionDidChange(region: MKCoordinateRegion, radius: Double) {
        DispatchQueue.global(qos: .utility).async {
            self.interactor.loadRestaurants(in: region.center, radius: radius)
        }
    }
    
    private func addAnnotations() {
        for restaurant in restaurants {
            let annotation = MKPointAnnotation()
            annotation.title = restaurant.name
            annotation.coordinate = CLLocationCoordinate2D(latitude: restaurant.latitude, longitude: restaurant.longitude)
            DispatchQueue.main.async {
                self.view.addAnnotation(annotation)
            }
        }
    }
    
    func createAnnotationView(for annotation: MKAnnotation) -> RestaurantAnnotation? {
        guard let restaurant = getRestaurant(for: annotation) else {
            return nil
        }
        return RestaurantAnnotation(restaurant: restaurant)
    }
    
    private func getRestaurant(for annotation: MKAnnotation) -> RestaurantModel? {
        return restaurants.first(where: { $0.name == annotation.title
            && $0.latitude == annotation.coordinate.latitude
            && $0.longitude == annotation.coordinate.longitude })
    }
    
    func annotationTapped(_ annotation: MKAnnotationView) {
//        guard let annotationView = annotation as? RestaurantAnnotation,
//              let selectedRestaurant = annotationView.restaurant
//        else {
//            return
//        }
        let restaurant = RestaurantModel()
        router.openRestaurantView(with: restaurant)
    }
}

extension MapPresenter: MapInteractorOutputProtocol {
    func restaurantsLoadSuccessfully(restaurants: [RestaurantModel]) {
        self.restaurants = restaurants
    }
    
    func restaurantsLoadUnsuccessfully() {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 55.751244, longitude: 37.618423)
        view.addAnnotation(annotation)
    }
    
    
}
