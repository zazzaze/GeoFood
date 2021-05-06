//
//  UserService.swift
//  GeoFood
//
//  Created by Егор on 25.04.2021.
//

import Foundation

class UserService {
    private static var service: UserService?
    private lazy var coreDataStore = CoreData.shared
    static var shared: UserService = UserService()
    
    private init() {
        currentUser = coreDataStore.loadUser()
        if currentUser == nil {
            currentUser = User(context: coreDataStore.viewContext)
        }
    }
    
    var isUserAuth: Bool {
        return currentUser?.token != nil && currentUser?.token != ""
    }
    
    var currentUser: User? = nil {
        didSet {
            DispatchQueue.global(qos: .background).async { [weak self] in
                self?.syncUserData()
            }
        }
    }
    
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
    
    func registerUser(with form: LoginForm, completion: @escaping (_ isSuccess: Bool) -> ()) {
        let dataTask = URLSession.shared.dataTask(with: RequestFactory.registrationRequest(with: form)) { data, response, error in
            completion(error == nil && (response as! HTTPURLResponse).statusCode != 500)
        }
        dataTask.resume()
    }
    
    func getRestaurantsNear(coordinate: CoordinateRequestModel, completion: @escaping ([RestaurantModel]?) -> ()) {
        let dataTask = URLSession.shared.dataTask(with: RequestFactory.restaurantsRequest(with: self.currentUser?.token ?? "", data: coordinate)) { data, response, error in
            if error != nil {
                completion(nil)
                return
            }
            print(String(data: data!, encoding: .utf8))
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
    
    func getRestaurantSales(restaurantId: Int32, completion: @escaping (_ sales: [RestaurantSaleModel]?) -> ()) {
        let dataTask = URLSession.shared.dataTask(with: RequestFactory.restaurantSalesRequest(with: currentUser?.token ?? "", restaurantId: restaurantId)) { data, response, error in
            print(String(data: data!, encoding: .utf8))
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
    
    func updateUserLocation(latitude: Double, longitude: Double) {
        let dataTask = URLSession.shared.dataTask(with: RequestFactory.locationRequest(with: currentUser?.token ?? "", longitude: longitude, latitude: latitude, date: Date())) { [unowned self] data, response, error in
            print("Location response: \(response)")
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
    
    func logout(completion: (_ isSuccess: Bool) -> ()) {
        coreDataStore.clearUser()
        coreDataStore.saveData()
        currentUser = nil
        completion(true)
    }
}
