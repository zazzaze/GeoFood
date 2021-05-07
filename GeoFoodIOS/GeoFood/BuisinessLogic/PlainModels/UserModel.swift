//
//  UserModel.swift
//  GeoFood
//
//  Created by Егор on 05.05.2021.
//

import Foundation

/// Модель пользователя
class UserModel {
    /// Токен авторизации пользователя
    let token: String
    /// Почта пользователя
    let login: String
    /// Пароль польователя
    let password: String
    
    /// Инициализация из модели пользователя из  CoreData
    /// - Parameter model: модель пользователя из CoreData
    init(from model: User) {
        token = model.token ?? ""
        login = model.login
        password = model.password
    }
}
