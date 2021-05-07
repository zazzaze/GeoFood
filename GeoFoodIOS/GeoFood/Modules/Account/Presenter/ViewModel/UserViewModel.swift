//
//  UserViewModel.swift
//  GeoFood
//
//  Created by Егор on 05.05.2021.
//

import Foundation

/// Модель представления пользователя
class UserViewModel {
    /// Логин пользователя
    let login: String
    
    /// Конструктор из модели пользователя
    /// - Parameter model: Модель пользователя
    init(from model: UserModel) {
        self.login = model.login
    }
}
