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
    func getRestaurantStocks(restaurantId: Int32, token: String, completion: @escaping (_ stocks: [RestaurantSaleModel]?) -> ())
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
    
    func getRestaurantStocks(restaurantId: Int32, token: String, completion: @escaping (_ stocks: [RestaurantSaleModel]?) -> ()) {
        var request = URLRequest(url: Endpoints.getStocks.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: ["id" : restaurantId], options: .prettyPrinted)
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(nil)
                return
            }
            let json = try? JSONDecoder().decode([RestaurantSaleModel].self, from: data)
            
            completion(json)
        }
        dataTask.resume()
    }
    
}
