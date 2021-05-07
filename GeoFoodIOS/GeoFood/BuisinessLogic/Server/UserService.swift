//
//  UserService.swift
//  GeoFood
//
//  Created by Егор on 25.04.2021.
//

import Foundation

/// Сервис пользователя
class UserService {
    /// Сервис CoreData
    private lazy var coreDataStore = CoreData.shared
    /// Общий объект сервиса
    static var shared: UserService = UserService()
    
    /// Конструктор
    private init() {
        currentUser = coreDataStore.loadUser()
        if currentUser == nil {
            currentUser = User(context: coreDataStore.viewContext)
        }
    }
    
    /// Авторизован ли пользователь
    var isUserAuth: Bool {
        return currentUser?.token != nil && currentUser?.token != ""
    }
    
    /// Текущий пользователь
    var currentUser: User? = nil {
        didSet {
            DispatchQueue.global(qos: .background).async { [weak self] in
                self?.syncUserData()
            }
        }
    }
    
    /// Синхронизировать позиции пользователя с сервером
    private func syncUserData() {
        if (currentUser?.untrackedLocations?.count == 0) {
            return;
        }
        guard let locations = coreDataStore.loadUntrackedLocations() else {
            return
        }
        
        for location in locations {
            let dataTask = URLSession.shared.dataTask(with: RequestFactory.locationRequest(with: currentUser?.token ?? "", longitude: location.longitude, latitude: location.latitude, date: location.date)) { [unowned self] data, response, error in
                if error != nil && (response as! HTTPURLResponse).statusCode == 500 {
                    return
                }
                self.coreDataStore.removeObject(location)
                self.coreDataStore.saveData()
            }
            dataTask.resume()
        }
    }
    
    /// Авторизировать пользователя
    /// - Parameters:
    ///   - form: Форма авторизации
    ///   - completion: Блок выполнения
    /// - Returns: Прошла ли авторизация пользователя успешно
    func authUser(with form: LoginForm, completion: @escaping (_ isSuccess: Bool) -> ()) {
        let dataTask = URLSession.shared.dataTask(with: RequestFactory.authRequest(with: form)) { [unowned self] data, response, error in
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data, options: []),
                  let dict = (json as? [String: Any]),
                  let token = dict["token"] as? String
            else {
                completion(false)
                return
            }
            coreDataStore.clearUser()
            let user = User(context: coreDataStore.viewContext)
            user.token = token
            user.login = form.login
            user.password = form.password
            user.untrackedLocations = self.currentUser?.untrackedLocations
            self.currentUser = user
            self.coreDataStore.saveData()
            completion(true)
        }
        dataTask.resume()
    }
    
    /// Регистрация пользователя
    /// - Parameters:
    ///   - form: Форма регистрации
    ///   - completion: Блок выполнения
    /// - Returns: прошла ли регистрация успешно
    func registerUser(with form: LoginForm, completion: @escaping (_ isSuccess: Bool) -> ()) {
        let dataTask = URLSession.shared.dataTask(with: RequestFactory.registrationRequest(with: form)) { data, response, error in
            completion(error == nil && (response as! HTTPURLResponse).statusCode != 500)
        }
        dataTask.resume()
    }
    
    /// Получить кафе рядом с положением пользователя
    /// - Parameters:
    ///   - coordinate: Координаты пользователя и радиус
    ///   - completion: Блок выполнения
    /// - Returns: Загруженные модели ресторанов
    func getRestaurantsNear(coordinate: CoordinateRequestModel, completion: @escaping ([RestaurantModel]?) -> ()) {
        let dataTask = URLSession.shared.dataTask(with: RequestFactory.restaurantsRequest(with: self.currentUser?.token ?? "", data: coordinate)) { data, response, error in
            if error != nil {
                completion(nil)
                return
            }
            guard let data = data,
                  let json = try? JSONDecoder().decode([RestaurantModel].self, from: data)
            else {
                completion(nil)
                return
            }
            
            completion(json)
        }
        dataTask.resume()
    }
    
    /// Получить акции кафе
    /// - Parameters:
    ///   - restaurantId: id кафе
    ///   - completion: Блок выполнения
    /// - Returns: Загруженные модели акций
    func getRestaurantSales(restaurantId: Int32, completion: @escaping (_ sales: [RestaurantSaleModel]?) -> ()) {
        let dataTask = URLSession.shared.dataTask(with: RequestFactory.restaurantSalesRequest(with: currentUser?.token ?? "", restaurantId: restaurantId)) { data, response, error in
            guard let data = data,
                  let json = try? JSONDecoder().decode([RestaurantSaleModel].self, from: data)
                  else {
                let rests = self.coreDataStore.loadRestaurants()?.map{ RestaurantModel(from: $0) }
                let sales = rests?.first(where: { $0.id == restaurantId })?.sales
                completion(sales)
                return
            }
            
            completion(json)
        }
        dataTask.resume()
    }
    
    /// Отправить обновление позиции пользователя
    /// - Parameters:
    ///   - latitude: Долгота позиции
    ///   - longitude: Широта позиции
    func updateUserLocation(latitude: Double, longitude: Double) {
        let dataTask = URLSession.shared.dataTask(with: RequestFactory.locationRequest(with: currentUser?.token ?? "", longitude: longitude, latitude: latitude, date: Date())) { [unowned self] data, response, error in
            if error != nil {
                let untrackedLocation = Location(context: self.coreDataStore.viewContext)
                untrackedLocation.latitude = latitude
                untrackedLocation.longitude = longitude
                untrackedLocation.date = Date()
                currentUser?.addToUntrackedLocations(untrackedLocation)
                self.coreDataStore.saveData()
                return
            }
        }
        
        dataTask.resume()
    }
    
    /// Выйти из аккаунта пользователя
    /// - Parameter completion: Блок выполнения
    /// - Returns: Прошел ли выход успешно
    func logout(completion: (_ isSuccess: Bool) -> ()) {
        coreDataStore.clearUser()
        coreDataStore.saveData()
        currentUser = nil
        completion(true)
    }
}
