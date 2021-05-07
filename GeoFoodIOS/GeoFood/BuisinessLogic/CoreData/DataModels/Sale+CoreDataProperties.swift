//
//  Sale+CoreDataProperties.swift
//  
//
//  Created by Егор on 26.04.2021.
//
//

import Foundation
import CoreData


extension Sale {
    
    /// Запрос на получение объектов из CoreData
    /// - Returns: Запрос
    @nonobjc public class func fetch() -> NSFetchRequest<Sale> {
        return NSFetchRequest<Sale>(entityName: "Sale")
    }
    
    /// id акции
    @NSManaged public var id: Int32
    /// Промокод акции
    @NSManaged public var code: String
    /// Картинка акции
    @NSManaged public var image: Data?
    /// Название акции
    @NSManaged public var name: String
    /// Цена акции
    @NSManaged public var price: Int32
    /// Специальная ли акция
    @NSManaged public var isSpecial: Bool
    /// Кафе, которое предоставляет акцию
    @NSManaged public var currentRestaurant: Restaurant?
    
    /// Конструктор
    /// - Parameters:
    ///   - plainModel: Модель акции
    ///   - context: Контекст CoreData
    convenience init(with plainModel: RestaurantSaleModel, context: NSManagedObjectContext) {
        self.init(context: context)
        
        id = plainModel.id
        code = plainModel.promo ?? "promo"
        name = plainModel.name
        price = plainModel.newPrice
        isSpecial = plainModel.special
        image = plainModel.image?.pngData()
    }
}
