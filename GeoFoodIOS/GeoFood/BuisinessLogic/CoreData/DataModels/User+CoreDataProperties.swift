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

    @nonobjc public class func fetch() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var token: String?
    @NSManaged public var login: String
    @NSManaged public var password: String
    @NSManaged public var restaurants: NSSet?
    @NSManaged public var untrackedLocations: NSSet?

}

// MARK: Generated accessors for restaurants
extension User {

    @objc(addRestaurantsObject:)
    @NSManaged public func addToRestaurants(_ value: Restaurant)

    @objc(removeRestaurantsObject:)
    @NSManaged public func removeFromRestaurants(_ value: Restaurant)

    @objc(addRestaurants:)
    @NSManaged public func addToRestaurants(_ values: NSSet)

    @objc(removeRestaurants:)
    @NSManaged public func removeFromRestaurants(_ values: NSSet)

}

// MARK: Generated accessors for untrackedLocations
extension User {

    @objc(addUntrackedLocationsObject:)
    @NSManaged public func addToUntrackedLocations(_ value: Location)

    @objc(removeUntrackedLocationsObject:)
    @NSManaged public func removeFromUntrackedLocations(_ value: Location)

    @objc(addUntrackedLocations:)
    @NSManaged public func addToUntrackedLocations(_ values: NSSet)

    @objc(removeUntrackedLocations:)
    @NSManaged public func removeFromUntrackedLocations(_ values: NSSet)

}
