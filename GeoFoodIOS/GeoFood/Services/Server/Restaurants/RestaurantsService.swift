//
//  RestaurantsService.swift
//  GeoFood
//
//  Created by Егор on 26.03.2021.
//

import Foundation
import MapKit
import Alamofire

protocol RestaurantServiceProtocol: class {
    func getRestaurantsNear(coordinate: CoordinateRequestModel, token: String, completion: @escaping ([RestaurantModel]?) -> ())
    func getRestaurantStocks(restaurantId: Int32, token: String, completion: @escaping (_ stocks: [RestaurantStockModel]?) -> ())
}

class RestaurantService: RestaurantServiceProtocol {
    
    func getRestaurantsNear(coordinate: CoordinateRequestModel, token: String, completion: @escaping ([RestaurantModel]?) -> ()) {
        var request = URLRequest(url: Endpoints.getRestaurants.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let opts = try! JSONEncoder().encode(coordinate)
        request.httpBody = opts
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            print((response as? HTTPURLResponse)?.statusCode)
            if error != nil {
                print(error?.localizedDescription)
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
    
    func getRestaurantStocks(restaurantId: Int32, token: String, completion: @escaping (_ stocks: [RestaurantStockModel]?) -> ()) {
        var request = URLRequest(url: Endpoints.getStocks.url)
        print(request.url?.absoluteURL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: ["id" : restaurantId], options: .prettyPrinted)
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(nil)
                return
            }
            print(String(data: data, encoding: .utf8))
            let json = try? JSONDecoder().decode([RestaurantStockModel].self, from: data)
            
            completion(json)
        }
        dataTask.resume()
    }
    
}
