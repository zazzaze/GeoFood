//
//  User+CoreDataProperties.swift
//  
//
//  Created by Егор on 26.04.2021.
//
//

import Foundation
import CoreData


extension User {
    
    /// Запрос для получения объектов
    /// - Returns: Запрос
    @nonobjc public class func fetch() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }
    
    /// Токен
    @NSManaged public var token: String?
    /// Почта
    @NSManaged public var login: String
    /// Пароль
    @NSManaged public var password: String
    /// Кафе
    @NSManaged public var restaurants: NSSet?
    /// Неотправленные позиции
    @NSManaged public var untrackedLocations: NSSet?

}

// MARK: Generated accessors for restaurants
extension User {
    
    /// Добавить кафе пользователю
    /// - Parameter value: Кафе для добавления
    @objc(addRestaurantsObject:)
    @NSManaged public func addToRestaurants(_ value: Restaurant)
    
    /// Удалить кафе из пользователя
    /// - Parameter value: Удаляемое кафе
    @objc(removeRestaurantsObject:)
    @NSManaged public func removeFromRestaurants(_ value: Restaurant)
    
    /// Добавление множества кафе
    /// - Parameter values: Множество кафе для добавления
    @objc(addRestaurants:)
    @NSManaged public func addToRestaurants(_ values: NSSet)
    
    /// Удаление множества кафе из пользователя
    /// - Parameter values: Множество кафе для удаления
    @objc(removeRestaurants:)
    @NSManaged public func removeFromRestaurants(_ values: NSSet)

}

// MARK: Generated accessors for untrackedLocations
extension User {
    
    /// Добавить неотправленную позицию
    /// - Parameter value: Неотправленная позиция для добавления
    @objc(addUntrackedLocationsObject:)
    @NSManaged public func addToUntrackedLocations(_ value: Location)
    
    /// Удалить неотправленную позицию
    /// - Parameter value: Неотправленная позиция для удаления
    @objc(removeUntrackedLocationsObject:)
    @NSManaged public func removeFromUntrackedLocations(_ value: Location)

    /// Добавить неотправленные позиции
    /// - Parameter value: Неотправленные позиции для добавления
    @objc(addUntrackedLocations:)
    @NSManaged public func addToUntrackedLocations(_ values: NSSet)

    /// Удалить неотправленные позиции
    /// - Parameter value: Неотправленные позиции для удаления
    @objc(removeUntrackedLocations:)
    @NSManaged public func removeFromUntrackedLocations(_ values: NSSet)

}
