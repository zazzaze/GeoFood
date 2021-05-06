//
//  RestaurantViewModel.swift
//  GeoFood
//
//  Created by Егор on 24.04.2021.
//

import Foundation
import UIKit
import MapKit

class RestaurantViewModel {
    let name: String
    var address: String
    let distance: String
    let typeImage: UIImage
    let logoImage: UIImage
    let sales: [SaleViewModel]
    let specialSales: [SaleViewModel]
    
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
