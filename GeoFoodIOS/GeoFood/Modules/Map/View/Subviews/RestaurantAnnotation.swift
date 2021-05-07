//
//  StockAnnotation.swift
//  GeoFood
//
//  Created by Егор on 26.03.2021.
//

import UIKit
import MapKit

/// Аннотация кафе на карте
class RestaurantAnnotation: MKAnnotationView {
    /// Кафе для аннотации
    var restaurant: MapRestaurantViewModel!
    
    /// Конструктор
    /// - Parameters:
    ///   - annotation: Исходная аннотация
    ///   - reuseIdentifier: id аннотации
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
    }
    
    /// Конфигурировать аннотацию по модели представления кафе
    /// - Parameter vm: Модель представления кафе
    func configure(with vm: MapRestaurantViewModel) {
        self.restaurant = vm
        self.image = vm.image
    }
    
    /// Конструктор
    /// - Parameter aDecoder: Кодер
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
