//
//  LoginEntryChecker.swift
//  GeoFood
//
//  Created by Егор on 16.03.2021.
//

import Foundation

/// Протокол проверки данных на авторизацию/регистрацию
protocol LoginEntryCheckerProtocol: class {
    /// Проверка формата строки для почты
    /// - Parameter email: проверяемая строка
    static func checkEmail(_ email: String) -> Bool
    /// Провекра формата строки с паролем
    /// - Parameter password: Проверяемая строка
    static func checkPassword(_ password: String) -> Bool
}

/// Объект для проверки введенных данных по формату
class LoginEntryChecker: LoginEntryCheckerProtocol {
    /// Проверка формата строки для почты
    /// - Parameter email: проверяемая строка
    static func checkEmail(_ email: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        let range = NSRange(location: 0, length: email.count)
        return regex.firstMatch(in: email, options: [], range: range) != nil
    }
    /// Провекра формата строки с паролем
    /// - Parameter password: Проверяемая строка
    static func checkPassword(_ password: String) -> Bool {
        password.count > 8
    }
}
