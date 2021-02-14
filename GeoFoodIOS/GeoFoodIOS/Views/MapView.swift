//
//  MapView.swift
//  GeoFoodIOS
//
//  Created by Егор on 16.01.2021.
//

import Foundation
import SwiftUI
import MapKit

struct MapView: UIViewRepresentable{
    @Binding var centerCoordinate: CLLocationCoordinate2D
    @Binding var currentLocation: CLLocationCoordinate2D
    @Binding var isUserInCenter: Bool
    let map = MKMapView()
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        map.delegate = context.coordinator
        return mapView
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(control: self)
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        let latDelta:CLLocationDegrees = 0.01
        let lonDelta:CLLocationDegrees = 0.01
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        uiView.setRegion(MKCoordinateRegion(center: currentLocation, span: span), animated: true)
    }
}
