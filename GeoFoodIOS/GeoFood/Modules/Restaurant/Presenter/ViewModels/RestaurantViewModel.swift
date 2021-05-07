//
//  RestaurantViewModel.swift
//  GeoFood
//
//  Created by Егор on 24.04.2021.
//

import Foundation
import UIKit
import MapKit

/// Модель представления данных кафе
class RestaurantViewModel {
    /// Названия кафе
    let name: String
    /// Адрес кафе
    var address: String
    /// Расстояние до кафе
    let distance: String
    /// Картинка типа акции
    let typeImage: UIImage
    /// Логотип кафе
    let logoImage: UIImage
    /// Акции кафе
    let sales: [SaleViewModel]
    /// Специальные кафе
    let specialSales: [SaleViewModel]
    
    /// Конструктор
    /// - Parameters:
    ///   - model: Модель представления данных кафе
    ///   - allSales: Все акции кафе
    init(with model: RestaurantModel, allSales: [RestaurantSaleModel]) {
        name = model.name
        address = model.location
        let locationCoords = CLLocation(latitude: model.latitude, longitude: model.longitude)
        let distanceValue = LocationManager.shared.userDistance(to: locationCoords) / 1000
        distance = "\(String(format: "%.1f", distanceValue))км"
        logoImage = model.logoImage ?? UIImage(named: "empty")!
        typeImage = model.type.image
        var sales = [SaleViewModel]()
        var specialSales = [SaleViewModel]()
        for sale in allSales {
            if sale.special {
                specialSales.append(SaleViewModel(with: sale))
            } else {
                sales.append(SaleViewModel(with: sale))
            }
        }
        self.sales = sales
        self.specialSales = specialSales
        let group = DispatchGroup()
        let geoCoder = CLGeocoder()
        group.enter()
        geoCoder.reverseGeocodeLocation(locationCoords, completionHandler: { placemarks, error in
            guard let placemarks = placemarks else {
                return
            }
            let placemark = placemarks[0]
            let houserNumber = placemark.subThoroughfare
            let street = placemark.thoroughfare
            if street == nil {
                self.address = ""
            } else if houserNumber == nil {
                self.address = "\(street!)"
            } else {
                self.address = "\(street!), \(houserNumber!)"
            }
            group.leave()
        })
        group.wait()
    }
}
