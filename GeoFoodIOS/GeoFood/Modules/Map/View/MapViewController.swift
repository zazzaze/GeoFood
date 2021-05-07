//
//  MapViewController.swift
//  GeoFood
//
//  Created by Егор on 17.03.2021.
//

import UIKit
import MapKit

/// Входные методы карты
protocol MapViewInput: AnyObject {
    /// Конфигурировать вью по модели представления карты
    /// - Parameter vm: Модель представления карты
    func configure(with vm: MapViewModel)
}

/// Контроллер карты
class MapViewController: UIViewController {
    
    /// Конфигуратор модуля карты
    let configurator: MapConfiguratorProtocol = MapConfigurator()
    /// Последняя позиция пользователя
    var lastLocation: CLLocation?
    /// Презентер карты
    var presenter: MapPresenterInput!
    
    /// Карта
    let mapView = MKMapView(frame: .zero)
    /// Сервис положения пользователя
    let locationManager = LocationManager.shared
    /// Модель представления карты
    var viewModel: MapViewModel?
    /// id аннотации
    private let annotationId = "restaurantAnnotation"
    /// Первое ли отображение карты
    private var isFirstAppear = true
    
    /// Коллекция типов кафе
    private var typesCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    /// Переместить карту на текущую позицию пользователя
    private let currentLocationButton = UIButton()
    
    
    /// Контроллер загрузился
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
    
    
    
    /// Контроллер отобразился
    /// - Parameter animated: Анимировано ли отобразился
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
    
    /// Изменить способ следования за пользователем
    @objc func changeFollowMode() {
        if mapView.userTrackingMode == .none {
            mapView.setUserTrackingMode(.follow, animated: true)
        } else {
            mapView.setUserTrackingMode(.followWithHeading, animated: true)
        }
    }
    
    /// Проверка возможности отслеживать позицию пользователя
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
    /// Конфигурировать по модели представления карты
    /// - Parameter vm: Модель представления карты
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
    /// Событие изменения отображаемого региона на карте
    /// - Parameters:
    ///   - mapView: Карта
    ///   - animated: Анимировано ли отобразился
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        presenter.regionDidChange(region: mapView.region, radius: mapView.currentRadius())
    }
    
    /// Сконфигурировать вью для аннотации
    /// - Parameters:
    ///   - mapView: Карта, на которой отображается аннотация
    ///   - annotation: Аннотация, для которой конфигурируется вью
    /// - Returns: Вью для аннотации
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
    
    /// Событие клика на аннотацию
    /// - Parameters:
    ///   - mapView: Карта
    ///   - view: Выбранное вью
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        mapView.deselectAnnotation(view.annotation, animated: false)
        presenter.annotationTapped(view)
    }
    
    /// Событие изменения способа следования за пользователем
    /// - Parameters:
    ///   - mapView: Карта
    ///   - mode: Способ следования
    ///   - animated: Анимировано ли изменен
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
    /// Событие изменения позиции пользователя
    /// - Parameters:
    ///   - manager: Сервис
    ///   - locations: Все позиции пользователя
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.presenter.updateUserLocation(locations)
    }
    
    /// Событие изменения доступа к отслеживанию позиции пользователя
    /// - Parameter manager: Сервис
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkAuthorizationStatus()
    }
}

extension MapViewController: UICollectionViewDataSource {
    /// Вычисление количества ячеек в коллекции
    /// - Parameters:
    ///   - collectionView: Коллекция типов
    ///   - section: Секция коллекции
    /// - Returns: Количество ячеек
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        RestaurantType.typesCount
    }
    
    /// Конфигурация ячейки коллекции
    /// - Parameters:
    ///   - collectionView: Коллекция типов
    ///   - indexPath: Индекс ячейки
    /// - Returns: Сконфигурированная ячейка
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "typeCell", for: indexPath) as? RestaurantTypeCell else {
            return RestaurantTypeCell()
        }
        cell.configure(with: RestaurantType(rawValue: Int32(indexPath.row)) ?? .coffee)
        return cell
    }
    
    /// Событие выбора ячейки коллекции
    /// - Parameters:
    ///   - collectionView: Коллекция типов
    ///   - indexPath: индекс выбранной ячейки
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
    /// Вычисление размера ячейки коллекции
    /// - Parameters:
    ///   - collectionView: Коллекция типов
    ///   - collectionViewLayout: Layout коллекции
    ///   - indexPath: Индекс ячейки
    /// - Returns: Размер ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 40)
    }
}
