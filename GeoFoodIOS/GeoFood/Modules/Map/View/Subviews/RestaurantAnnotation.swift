//
//  StockAnnotation.swift
//  GeoFood
//
//  Created by Егор on 26.03.2021.
//

import UIKit
import MapKit

class RestaurantAnnotation: MKAnnotationView {
    var restaurant: MapRestaurantViewModel!
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
    }
    
    func configure(with vm: MapRestaurantViewModel) {
        self.restaurant = vm
        self.image = vm.image
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
