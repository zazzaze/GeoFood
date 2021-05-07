//
//  CoreDataStore.swift
//  GeoFood
//
//  Created by Егор on 25.04.2021.
//

import Foundation
import CoreData

/// Сервис взаимодействия с CoreData
class CoreData {
    /// Общий экземпляр типа
    static let shared = CoreData()
    /// Контейнер CoreData
    private var persistentContainer: NSPersistentContainer = {
      let container = NSPersistentContainer(name: "GeoFood")
      container.loadPersistentStores(completionHandler: { (storeDescription, error) in
          if let error = error as NSError? {
              fatalError("Unresolved error \(error), \(error.userInfo)")
          }
      })
      return container
    }()
    
    /// Контекст CoreData
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    /// Получить сохраненного пользователя
    /// - Returns: Сохраненный пользователь или nil
    func loadUser() -> User? {
        let fetchRequest = User.fetch()
        return try? viewContext.fetch(fetchRequest).first
    }
    
    /// Получить сохраненные кафе
    /// - Returns: Массив кафе или nil
    func loadRestaurants() -> [Restaurant]? {
        let fetchRequest = Restaurant.fetch()
        return try? viewContext.fetch(fetchRequest)
    }
    
    /// Сохранить изменения
    func saveData() {
        if viewContext.hasChanges {
            try? viewContext.save()
        }
    }
    
    /// Получить сохраненные позиции пользователя
    /// - Returns: Позиции пользователя или nil
    func loadUntrackedLocations() -> [Location]? {
        let fetchRequest = Location.fetch()
        return try? viewContext.fetch(fetchRequest)
    }
    
    /// Удалить объект из база
    /// - Parameter object: Удаляемый объект
    func removeObject(_ object: NSManagedObject) {
        viewContext.delete(object)
    }
    
    /// Удалить текущего пользователя
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
