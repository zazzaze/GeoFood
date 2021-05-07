//
//  Location+CoreDataProperties.swift
//  
//
//  Created by Егор on 26.04.2021.
//
//

import Foundation
import CoreData


extension Location {
    
    /// Запрос на получение объектов
    /// - Returns: Запрос
    @nonobjc public class func fetch() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }
    
    /// Широта
    @NSManaged public var latitude: Double
    /// Долгота
    @NSManaged public var longitude: Double
    /// Дата когда пользователь был на позиции
    @NSManaged public var date: Date
    /// Пользователь
    @NSManaged public var user: User?

}
