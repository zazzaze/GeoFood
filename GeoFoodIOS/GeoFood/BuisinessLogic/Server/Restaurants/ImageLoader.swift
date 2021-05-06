//
//  ImageLoader.swift
//  GeoFood
//
//  Created by Егор on 26.03.2021.
//

import Foundation
import Alamofire

protocol ImageLoaderProtocol: class {
    static func loadRestaurantImage(restId: Int32, completion: @escaping (_ data: Data?) -> ())
    static func loadSaleImage(saleId: Int32, completion: @escaping (_ data: Data?) -> ())
}

class ImageLoader: ImageLoaderProtocol {
    static func loadRestaurantImage(restId: Int32, completion: @escaping (_ data: Data?) -> ()) {
        let dataTask = URLSession.shared.dataTask(with: RequestFactory.loadRestaurantImage(for: restId)) { data, response, error in
            completion(data)
        }
        dataTask.resume()
    }
    
    static func loadSaleImage(saleId: Int32, completion: @escaping (_ data: Data?) -> ()) {
        let dataTask = URLSession.shared.dataTask(with: RequestFactory.loadSaleImage(for: saleId)) { data, response, error in
            print(error)
            completion(data)
        }
        dataTask.resume()
    }
}
