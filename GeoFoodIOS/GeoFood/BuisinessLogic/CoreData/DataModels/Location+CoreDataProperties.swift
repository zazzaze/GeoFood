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

    @nonobjc public class func fetch() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var date: Date
    @NSManaged public var user: User?

}
