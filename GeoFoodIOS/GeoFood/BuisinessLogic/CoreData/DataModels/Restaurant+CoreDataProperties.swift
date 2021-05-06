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

    @nonobjc public class func fetch() -> NSFetchRequest<Restaurant> {
        return NSFetchRequest<Restaurant>(entityName: "Restaurant")
    }

    @NSManaged public var id: Int32
    @NSManaged public var address: String
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var logoImage: Data?
    @NSManaged public var name: String
    @NSManaged public var sales: NSSet?
    @NSManaged public var type: RestaurantType
    
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

    @objc(addSalesObject:)
    @NSManaged public func addToSales(_ value: Sale)

    @objc(removeSalesObject:)
    @NSManaged public func removeFromSales(_ value: Sale)

    @objc(addSales:)
    @NSManaged public func addToSales(_ values: NSSet)

    @objc(removeSales:)
    @NSManaged public func removeFromSales(_ values: NSSet)

}
