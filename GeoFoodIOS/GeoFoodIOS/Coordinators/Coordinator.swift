//
//  Coordinator.swift
//  GeoFoodIOS
//
//  Created by Егор on 16.01.2021.
//

import Foundation
import MapKit

final class Coordinator: NSObject, MKMapViewDelegate {
    var control: MapView
    
    init(control: MapView){
        self.control = control
    }
    
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        if !mapView.showsUserLocation {
            control.centerCoordinate = mapView.centerCoordinate
        }
    }
}
