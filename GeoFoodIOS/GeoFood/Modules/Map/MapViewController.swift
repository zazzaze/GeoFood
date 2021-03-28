//
//  MapViewController.swift
//  GeoFood
//
//  Created by Егор on 17.03.2021.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate {

    let configurator: MapConfiguratorProtocol = MapConfigurator()
    var presenter: MapPresenterProtocol!
    
    let mapView = MKMapView(frame: .zero)
    let locationManager = CLLocationManager()
    private let annotationId = "restaurantAnnotation"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        view.backgroundColor = .white
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(.follow, animated: true)
        navigationController?.setNavigationBarHidden(true, animated: false)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.register(MKAnnotationView.self, forAnnotationViewWithReuseIdentifier: annotationId)
        locationManager.requestWhenInUseAuthorization()
        mapView.delegate = self
        view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func addAnnotation(_ annotation: MKAnnotation) {
        mapView.addAnnotation(annotation)
    }
    
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        presenter.regionDidChange(region: mapView.region, radius: mapView.currentRadius())
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationId) as? RestaurantAnnotation
        if annotation is MKUserLocation {
            let userAnnotation = MKUserLocationView()
            userAnnotation.annotation = annotation
            return userAnnotation
        }
        
        annotationView = presenter.createAnnotationView(for: annotation)
        annotationView?.bounds = CGRect(x: 0, y: 0, width: 40, height: 40)
        annotationView?.layer.masksToBounds = true
        annotationView?.layer.cornerRadius = 20
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        presenter.annotationTapped(view)
    }
}
