//
//  AuthorizationInteractor.swift
//  GeoFood
//
//  Created by Егор on 11.03.2021.
//

import Foundation

/// Входные методы интерактора
protocol AuthorizationInteractorProtocol: class {
    /// Авторизовать пользователя
    /// - Parameters:
    ///   - withEmail: Почта
    ///   - password: Пароль
    func authUser(withEmail: String, password: String)
    var isUserAuth: Bool { get }
}

/// Выходные методы интерактора
protocol AuthorizationInteractorOutputProtocol: class {
    /// Авторизация прошла неуспешно
    func authorizationUnsuccessfully()
    /// Авторизация прошла успешно
    func authorizationSuccessfully()
}

/// Интерактор авторизации
class AuthorizationInteractor: AuthorizationInteractorProtocol {
    /// Авторизован ли пользователь
    var isUserAuth: Bool {
        return userService.isUserAuth
    }
    
    /// Презентер авторизации
    weak var presenter: AuthorizationInteractorOutputProtocol!
    /// Сервис пользователя
    var userService = UserService.shared
    
    /// Конструктор
    /// - Parameter presenter: Презентер
    required init(presenter: AuthorizationInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    /// Авторизовать пользователя
    /// - Parameters:
    ///   - withEmail: Почта
    ///   - password: Пароль
    func authUser(withEmail: String, password: String) {
        userService.authUser(with: LoginForm(login: withEmail, password: password)) { isSuccess in
            if !isSuccess {
                self.presenter.authorizationUnsuccessfully()
                return
            }
            self.presenter.authorizationSuccessfully()
        }
    }
}
