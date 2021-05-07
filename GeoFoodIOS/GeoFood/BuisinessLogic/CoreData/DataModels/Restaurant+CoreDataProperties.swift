//
//  Restaurant+CoreDataProperties.swift
//  
//
//  Created by Егор on 26.04.2021.
//
//

import Foundation
import CoreData


extension Restaurant {
    
    /// Запрос на загрузку объектов из CoreData
    /// - Returns: Запрос
    @nonobjc public class func fetch() -> NSFetchRequest<Restaurant> {
        return NSFetchRequest<Restaurant>(entityName: "Restaurant")
    }
    
    /// id кафе
    @NSManaged public var id: Int32
    /// Адрес кафе
    @NSManaged public var address: String
    /// Широта кафе
    @NSManaged public var latitude: Double
    /// Долгота кафе
    @NSManaged public var longitude: Double
    /// Картинка кафе
    @NSManaged public var logoImage: Data?
    /// Название кафе
    @NSManaged public var name: String
    /// Акции кафе
    @NSManaged public var sales: NSSet?
    /// Тип кафе
    @NSManaged public var type: RestaurantType
    
    /// Конструктор кафе из модели кафе
    /// - Parameters:
    ///   - plainModel: Модель кафе
    ///   - context: Контекст CoreData
    convenience init(with plainModel: RestaurantModel, context: NSManagedObjectContext) {
        self.init(context: context)
        id = plainModel.id
        address = plainModel.location
        latitude = plainModel.latitude
        longitude = plainModel.longitude
        type = plainModel.type
        logoImage = plainModel.logoImage?.pngData()
    }

}

// MARK: Generated accessors for sales
extension Restaurant {
    
    /// Добавить акцию к кафе
    /// - Parameter value: Добавляемая акция
    @objc(addSalesObject:)
    @NSManaged public func addToSales(_ value: Sale)
    
    /// Удалить акцию из кафе
    /// - Parameter value: Удаляемая акция
    @objc(removeSalesObject:)
    @NSManaged public func removeFromSales(_ value: Sale)
    
    /// Добавить множество акций к кафе
    /// - Parameter values: Множество акций для добавления
    @objc(addSales:)
    @NSManaged public func addToSales(_ values: NSSet)

    /// Удалить множество акций из кафе
    /// - Parameter values: Множество акций для удаления
    @objc(removeSales:)
    @NSManaged public func removeFromSales(_ values: NSSet)

}
