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
    func getRestaurantStocks(restaurantId: String, token: String, completion: @escaping (_ stocks: [RestaurantStockModel]?) -> ())
}

class RestaurantService: RestaurantServiceProtocol {
    
    func getRestaurantsNear(coordinate: CoordinateRequestModel, token: String, completion: @escaping ([RestaurantModel]?) -> ()) {
        guard let body = try? JSONEncoder().encode(coordinate) else {
            completion(nil)
            return
        }
        
        let contentTypeHeader = HTTPHeader(name: "Content-Type", value: "application/json")
        let bearerHeader = HTTPHeader(name: "Authorization", value: "Bearer \(token)")
        AF.request(Endpoints.getRestaurants.url, method: .post, parameters: body, headers: [contentTypeHeader, bearerHeader]).response { response in
            if response.error != nil {
                completion(nil)
                return
            }
            
            guard let data = response.data,
                  let json = try? JSONDecoder().decode([RestaurantModel].self, from: data)
            else {
                completion(nil)
                return
            }
            
            completion(json)
                  
        }
    }
    
    func getRestaurantStocks(restaurantId: String, token: String, completion: @escaping (_ stocks: [RestaurantStockModel]?) -> ()) {
        let contentTypeHeader = HTTPHeader(name: "Content-Type", value: "application/json")
        let bearerHeader = HTTPHeader(name: "Authorization", value: "Bearer \(token)")
        AF.request("\(Endpoints.getStocks.url.absoluteString)?id=\(restaurantId)", method: .post, headers: [contentTypeHeader, bearerHeader]).response { response in
            guard let data = response.data,
                  let json = try? JSONDecoder().decode([RestaurantStockModel].self, from: data)
            else {
                completion(nil)
                return
            }
            
            completion(json)
        }
    }
    
}
