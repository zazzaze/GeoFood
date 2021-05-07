//
//  RequestFactory.swift
//  GeoFood
//
//  Created by Егор on 25.04.2021.
//

import Foundation

/// Фабрика запросов
final class RequestFactory {
    /// Запрос авторизации пользователя
    /// - Parameter form: Форма авторизации
    /// - Returns: Сформированный запрос
    static func authRequest(with form: LoginForm) -> URLRequest {
        let url = Endpoints.login.url
        var request = URLRequest(url: url)
        let data = ["login": form.login, "password": form.password]
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
        return request
    }
    
    /// Запрос регистрации пользователя
    /// - Parameter form: Форма регистрации
    /// - Returns: Сформированный запрос
    static func registrationRequest(with form: LoginForm) -> URLRequest {
        let url = Endpoints.register.url
        let data = ["login" : form.login, "password" : form.password]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
        return request
    }
    
    /// Запрос получения акций кафе
    /// - Parameters:
    ///   - token: токен пользователя
    ///   - restaurantId: id кафе
    /// - Returns: Сформированный запрос
    static func restaurantSalesRequest(with token: String, restaurantId: Int32) -> URLRequest {
        var request = URLRequest(url: Endpoints.getStocks.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: ["id" : restaurantId], options: .prettyPrinted)
        return request
    }
    
    /// Запрос кафе рядом с позицией
    /// - Parameters:
    ///   - token: токен пользователя
    ///   - coordinate: Координаты для запроса
    /// - Returns: Сформированный запрос
    static func restaurantsRequest(with token: String, data coordinate: CoordinateRequestModel) -> URLRequest {
        var request = URLRequest(url: Endpoints.getRestaurants.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let opts = try! JSONEncoder().encode(coordinate)
        request.httpBody = opts
        return request
    }
    
    /// Запрос обновления позиции пользователя
    /// - Parameters:
    ///   - token: Токен пользователя
    ///   - longitude: Долгота позиции
    ///   - latitude: Широта позиции
    ///   - date: Дата отправки запроса
    /// - Returns: Сформированный запрос
    static func locationRequest(with token: String, longitude: Double, latitude: Double, date: Date) -> URLRequest {
        var request = URLRequest(url: Endpoints.locationUpdate.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let data = try! JSONSerialization.data(withJSONObject: ["longitude": longitude, "latitude": latitude, "date": dateFormat.string(from: date)])
        request.httpBody = try! JSONSerialization.data(withJSONObject: ["longitude": longitude, "latitude": latitude, "date": dateFormat.string(from: date)], options: .prettyPrinted)
        return request
    }
    
    /// Запрос загрузки картинки кафе
    /// - Parameter restaurantId: id кафе
    /// - Returns: Сформированный запрос
    static func loadRestaurantImage(for restaurantId: Int32) -> URLRequest {
        var request = URLRequest(url: Endpoints.loadShopImage.url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = try! JSONSerialization.data(withJSONObject: ["shopId": restaurantId], options: .prettyPrinted)
        return request
    }
    
    /// Запрос загрузки картинки акции
    /// - Parameter saleId: id акции
    /// - Returns: Сформированный запрос
    static func loadSaleImage(for saleId: Int32) -> URLRequest {
        var request = URLRequest(url: Endpoints.loadSaleImage.url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = try! JSONSerialization.data(withJSONObject: ["stockId": saleId], options: .prettyPrinted)
        return request
    }
}
