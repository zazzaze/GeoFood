//
//  LoginForm.swift
//  GeoFood
//
//  Created by Егор on 16.03.2021.
//

import Foundation

/// Форма авторизации и регистрации пользователя
struct LoginForm: Codable {
    /// Почта пользователя
    var login: String
    /// Пароль пользователя
    var password: String
}
