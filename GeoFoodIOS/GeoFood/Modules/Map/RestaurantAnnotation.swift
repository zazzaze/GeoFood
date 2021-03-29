//
//  StockAnnotation.swift
//  GeoFood
//
//  Created by Егор on 26.03.2021.
//

import UIKit
import MapKit

class RestaurantAnnotation: MKAnnotationView {
    var restaurant: RestaurantModel! {
        didSet {
            setUp()
        }
    }
    init(restaurant: RestaurantModel) {
        super.init(annotation: nil, reuseIdentifier: nil)
        self.restaurant = restaurant
        setUp()
    }
    
    private func setUp() {
        self.image = restaurant.logo ?? UIImage(named: "empty")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
