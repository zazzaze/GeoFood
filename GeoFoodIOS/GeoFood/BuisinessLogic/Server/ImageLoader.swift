//
//  ImageLoader.swift
//  GeoFood
//
//  Created by Егор on 26.03.2021.
//

import Foundation
import Alamofire

/// Протокол загрузчика фотографий
protocol ImageLoaderProtocol: class {
    /// Загрузить картинку для кафе
    /// - Parameters:
    ///   - restId: id ресторана
    ///   - completion: Блок выполнения
    static func loadRestaurantImage(restId: Int32, completion: @escaping (_ data: Data?) -> ())
    /// Загрузить картинку для акции
    /// - Parameters:
    ///   - saleId: id акции
    ///   - completion: Блоак выполнения
    static func loadSaleImage(saleId: Int32, completion: @escaping (_ data: Data?) -> ())
}

/// Загрузчик фотографий из сети
class ImageLoader: ImageLoaderProtocol {
    /// Загрузить картинку для кафе
    /// - Parameters:
    ///   - restId: id ресторана
    ///   - completion: Блок выполнения
    static func loadRestaurantImage(restId: Int32, completion: @escaping (_ data: Data?) -> ()) {
        let dataTask = URLSession.shared.dataTask(with: RequestFactory.loadRestaurantImage(for: restId)) { data, response, error in
            completion(data)
        }
        dataTask.resume()
    }
    
    /// Загрузить картинку для акции
    /// - Parameters:
    ///   - saleId: id акции
    ///   - completion: Блоак выполнения
    static func loadSaleImage(saleId: Int32, completion: @escaping (_ data: Data?) -> ()) {
        let dataTask = URLSession.shared.dataTask(with: RequestFactory.loadSaleImage(for: saleId)) { data, response, error in
            completion(data)
        }
        dataTask.resume()
    }
}
