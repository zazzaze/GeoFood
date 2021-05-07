//
//  RegistrationInteractor.swift
//  GeoFood
//
//  Created by Егор on 15.03.2021.
//

import Foundation

/// Входные методы интерактора
protocol RegistrationInteractorInput: class {
    /// Зарегистрировать пользователя
    /// - Parameters:
    ///   - withEmail: Почта пользователя
    ///   - password: Пароль
    func registerUser(withEmail: String, password: String)
}

/// Выходные методы интерактора
protocol RegistrationPresenterOutput: class {
    /// Регистрация прошла успешно
    func registrationSuccessfully()
    /// Не удалось зарегистрироваться
    func registrationUnsuccessfully()
}

/// Интерактор регистрации
class RegistrationInteractor: RegistrationInteractorInput {
    /// Презентер регистрации
    weak var presenter: RegistrationPresenterOutput!
    /// Сервис пользователя
    var userService: UserService = UserService.shared
    
    /// Конструктор
    /// - Parameter presenter: Презентер регистрации
    required init(presenter: RegistrationPresenterOutput) {
        self.presenter = presenter
    }
    
    /// Зарегистрировать пользователя
    /// - Parameters:
    ///   - withEmail: Почта пользователя
    ///   - password: Пароль
    func registerUser(withEmail: String, password: String) {
        userService.registerUser(with: LoginForm(login: withEmail, password: password)) { isSuccess in
            if isSuccess {
                self.userService.authUser(with: LoginForm(login: withEmail, password: password)) { isSuccess in
                    if isSuccess {
                        self.presenter.registrationSuccessfully()
                    } else {
                        self.presenter.registrationUnsuccessfully()
                    }
                }
            } else {
                self.presenter.registrationUnsuccessfully()
            }
        }
    }
}
