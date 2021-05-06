//
//  CoreDataStore.swift
//  GeoFood
//
//  Created by Егор on 25.04.2021.
//

import Foundation
import CoreData

class CoreData {
    static let shared = CoreData()
    private var persistentContainer: NSPersistentContainer = {
      let container = NSPersistentContainer(name: "GeoFood")
      container.loadPersistentStores(completionHandler: { (storeDescription, error) in
          if let error = error as NSError? {
              fatalError("Unresolved error \(error), \(error.userInfo)")
          }
      })
      return container
    }()
    
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func loadUser() -> User? {
        let fetchRequest = User.fetch()
        return try? viewContext.fetch(fetchRequest).first
    }
    
    func loadRestaurants() -> [Restaurant]? {
        let fetchRequest = Restaurant.fetch()
        return try? viewContext.fetch(fetchRequest)
    }
    
    func saveData() {
        if viewContext.hasChanges {
            try? viewContext.save()
        }
    }
    
    func loadUntrackedLocations() -> [Location]? {
        let fetchRequest = Location.fetch()
        return try? viewContext.fetch(fetchRequest)
    }
    
    func removeObject(_ object: NSManagedObject) {
        viewContext.delete(object)
    }
    
    func clearUser() {
        let fetchRequest = User.fetch()
        guard let users = try? viewContext.fetch(fetchRequest) else {
            return
        }
        for user in users {
            self.removeObject(user)
        }
        self.saveData()
    }
    
}
