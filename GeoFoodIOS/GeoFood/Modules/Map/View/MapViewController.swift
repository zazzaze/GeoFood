//
//  MapViewController.swift
//  GeoFood
//
//  Created by Егор on 17.03.2021.
//

import UIKit
import MapKit

protocol MapViewInput: AnyObject {
    func configure(with vm: MapViewModel)
}

class MapViewController: UIViewController {

    let configurator: MapConfiguratorProtocol = MapConfigurator()
    var lastLocation: CLLocation?
    var presenter: MapPresenterInput!
    
    let mapView = MKMapView(frame: .zero)
    let locationManager = LocationManager.shared
    var viewModel: MapViewModel?
    private let annotationId = "restaurantAnnotation"
    private var isFirstAppear = true
    
    private var typesCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    private let currentLocationButton = UIButton()
    private var isModeFollow = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        view.backgroundColor = .white
        mapView.showsUserLocation = true
        mapView.showsCompass = false
        navigationController?.setNavigationBarHidden(true, animated: false)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.register(RestaurantAnnotation.self, forAnnotationViewWithReuseIdentifier: annotationId)
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        mapView.delegate = self
        view.addSubview(mapView)
        
        typesCollection.translatesAutoresizingMaskIntoConstraints = false
        typesCollection.dataSource = self
        typesCollection.delegate = self
        typesCollection.register(RestaurantTypeCell.self, forCellWithReuseIdentifier: "typeCell")
        typesCollection.backgroundColor = .clear
        typesCollection.showsHorizontalScrollIndicator = false
        typesCollection.contentInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        view.addSubview(typesCollection)
    
        currentLocationButton.frame = CGRect(x: view.frame.maxX - 70, y: view.frame.minY + 50, width: 50, height: 50)
        currentLocationButton.layer.cornerRadius = currentLocationButton.frame.width / 2
        currentLocationButton.backgroundColor = .white
        currentLocationButton.imageView?.tintColor = UIColor(named: "dark_blue")
        currentLocationButton.addTarget(self, action: #selector(changeFollowMode), for: .touchUpInside)
        view.addSubview(currentLocationButton)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            typesCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            typesCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            typesCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            typesCollection.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        if isFirstAppear {
            mapView.setUserTrackingMode(.followWithHeading, animated: false)
            isFirstAppear = false
        }
        checkAuthorizationStatus()
        presenter.viewDidAppear()
    }
    
    @objc func changeFollowMode() {
        if mapView.userTrackingMode == .none {
            mapView.setUserTrackingMode(.follow, animated: true)
        } else {
            mapView.setUserTrackingMode(.followWithHeading, animated: true)
        }
    }
    
    private func checkAuthorizationStatus() {
        if locationManager.authorizationStatus == .denied {
            let alert = UIAlertController(title: "Ошибка", message: "Разрешите доступ к вашей геопозиции", preferredStyle: .alert)
            let action = UIAlertAction(title: "Перейти в настройки", style: .default, handler: { _ in
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }

                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl)
                }
            })
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
}

extension MapViewController: MapViewInput {
    func configure(with vm: MapViewModel) {
        self.viewModel = vm
        if vm.deleteAll {
            self.mapView.removeAnnotations(mapView.annotations)
        }
        self.mapView.removeAnnotations(self.viewModel?.deletedRestaurants.map{ $0.annotation } ?? [])
        
        for rest in viewModel!.mapRestaurants {
            mapView.addAnnotation(rest.annotation)
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        presenter.regionDidChange(region: mapView.region, radius: mapView.currentRadius())
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            let userAnnotation = MKUserLocationView()
            userAnnotation.annotation = annotation
            userAnnotation.tintColor = UIColor(named: "dark_blue")
            return userAnnotation
        }
        guard let restaurantVM = self.viewModel?.mapRestaurants.first(where: { $0.annotation.coordinate.latitude == annotation.coordinate.latitude && $0.annotation.coordinate.longitude == annotation.coordinate.longitude })
        else {
            return nil
        }
        guard let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationId) as? RestaurantAnnotation else {
            let restAnnotation = RestaurantAnnotation(annotation: annotation, reuseIdentifier: annotationId)
            restAnnotation.restaurant = restaurantVM
            return restAnnotation
        }
        annotationView.configure(with: restaurantVM)
        annotationView.bounds = CGRect(x: 0, y: 0, width: 40, height: 40)
        annotationView.layer.masksToBounds = true
        annotationView.layer.cornerRadius = 20
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        mapView.deselectAnnotation(view.annotation, animated: false)
        presenter.annotationTapped(view)
    }
    
    func mapView(_ mapView: MKMapView, didChange mode: MKUserTrackingMode, animated: Bool) {
        if mode == .follow {
            currentLocationButton.setImage(UIImage(systemName: "location.fill"), for: .normal)
        } else if mode == .followWithHeading {
            currentLocationButton.setImage(UIImage(systemName: "location.fill"), for: .normal)
        } else {
            currentLocationButton.setImage(UIImage(systemName: "location"), for: .normal)
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.presenter.updateUserLocation(locations)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkAuthorizationStatus()
    }
}

extension MapViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        RestaurantType.typesCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "typeCell", for: indexPath) as? RestaurantTypeCell else {
            return RestaurantTypeCell()
        }
        cell.configure(with: RestaurantType(rawValue: Int32(indexPath.row)) ?? .coffee)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? RestaurantTypeCell else {
            return
        }
        cell.selectionMode.toggle()
        cell.layer.borderWidth = cell.selectionMode ? 3 : 0
        self.presenter.changeFilter(for: indexPath.row, state: cell.selectionMode)
    }
    
}

extension MapViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 40)
    }
}
