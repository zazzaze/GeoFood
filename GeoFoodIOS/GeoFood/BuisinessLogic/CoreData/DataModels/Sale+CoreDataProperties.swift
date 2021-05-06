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

    @nonobjc public class func fetch() -> NSFetchRequest<Sale> {
        return NSFetchRequest<Sale>(entityName: "Sale")
    }

    @NSManaged public var id: Int32
    @NSManaged public var code: String
    @NSManaged public var image: Data?
    @NSManaged public var name: String
    @NSManaged public var price: Int32
    @NSManaged public var isSpecial: Bool
    @NSManaged public var currentRestaurant: Restaurant?

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
