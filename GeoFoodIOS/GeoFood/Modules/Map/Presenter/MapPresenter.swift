//
//  MapPresenter.swift
//  GeoFood
//
//  Created by Егор on 17.03.2021.
//

import Foundation
import MapKit

/// Входные методы презентера
protocol MapPresenterInput: class {
    /// Регион, отображаемый на карте, изменен
    /// - Parameters:
    ///   - region: Отображаемый регион
    ///   - radius: Радиус отображаемого региона
    func regionDidChange(region: MKCoordinateRegion, radius: Double)
    /// Событие нажатия на аннотацию
    /// - Parameter annotation: Выбраная аннотация
    func annotationTapped(_ annotation: MKAnnotationView)
    /// Обновить позицию пользователя если она изменилась на 100 метров
    /// - Parameter locations: Новая позиция пользователя
    func updateUserLocation(_ locations: [CLLocation])
    /// Событие изменения выбранных фильров
    /// - Parameters:
    ///   - index: Числовое значение фильтра
    ///   - state: Состояние фильтра
    func changeFilter(for index: Int, state: Bool)
    /// Контроллер отобразился
    func viewDidAppear()
}

/// Презентер кафе
class MapPresenter: MapPresenterInput {
    /// Последняя позиция пользователя
    private var lastLocation: CLLocation?
    /// Типы кафе для фильтрации
    private var filterTypes: [RestaurantType] = []
    /// Вью кафе
    private weak var view: MapViewInput!
    /// Интерактор кафе
    var interactor: MapInteractorInput!
    /// Роутер кафе
    var router: MapRouterProtocol!
    /// Все кафе
    var restaurants: [RestaurantModel]  = []
    /// Текущая модель представления
    private var currentViewModel: MapViewModel?
    /// Последний отображаемый на карте регион
    private var lastRegion: MKCoordinateRegion?
    
    /// Конструктор
    /// - Parameter view: Контроллер карты
    required init(view: MapViewController) {
        self.view = view
    }
    
    /// Регион, отображаемый на карте, изменен
    /// - Parameters:
    ///   - region: Отображаемый регион
    ///   - radius: Радиус отображаемого региона
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
    
    /// Событие нажатия на аннотацию
    /// - Parameter annotation: Выбраная аннотация
    func annotationTapped(_ annotation: MKAnnotationView) {
        guard let restAnnotation = annotation as? RestaurantAnnotation,
              let restaurant = self.restaurants.first(where: { $0.id == restAnnotation.restaurant.id })
        else {
            return
        }
        
        self.router.openRestaurantView(with: restaurant)
    }
    
    /// Обновить позицию пользователя если она изменилась на 100 метров
    /// - Parameter locations: Новая позиция пользователя
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
    
    /// Событие изменения выбранных фильров
    /// - Parameters:
    ///   - index: Числовое значение фильтра
    ///   - state: Состояние фильтра
    func changeFilter(for index: Int, state: Bool) {
        if state {
            addFilter(for: index)
        } else {
            removeFilter(for: index)
        }
    }
    
    /// Добавить фильтр
    /// - Parameter index: Числовое значение филтра
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
    
    /// Удалить фильтр
    /// - Parameter index: Числовое значение фильтра
    private func removeFilter(for index: Int) {
        filterTypes.removeAll(where: { $0.rawValue == Int32(index) })
        guard let currentViewModel = currentViewModel else {
            return
        }
        currentViewModel.updateForTypes(filterTypes)
        self.view.configure(with: currentViewModel)
    }
    
    /// Контроллер отобразился
    func viewDidAppear() {
        guard let coordinate = LocationManager.shared.location else {
            return
        }
        interactor.loadRestaurants(in: coordinate.coordinate, radius: 1000)
    }
}

extension MapPresenter: MapInteractorOutput {
    /// Кафе загружены
    /// - Parameter restaurants: Массив загруженных кафе
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
