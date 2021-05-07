//
//  AuthorizationRouter.swift
//  GeoFood
//
//  Created by Егор on 11.03.2021.
//

import Foundation

/// Протокол роутера авторизации
protocol AuthorizationRouterProtocol: class {
    /// Открыть модуль регистрации
    func openRegistrationView()
    /// Открыть модуль аккаунта
    /// - Parameter animated: Анимировано
    func openAccountView(animated: Bool)
}

/// Роутер авторизации
class AuthorizationRouter: AuthorizationRouterProtocol {
    /// Контроллер авторизации
    var view: AuthorizationViewProtocol!
    
    /// Конструктор
    /// - Parameter view: Контроллер авторизации
    required init(view: AuthorizationViewController) {
        self.view = view
    }
    
    /// Открыть модуль регистрации
    func openRegistrationView() {
        let registrationVc = RegistrationViewController()
        view.getNavigationController()?.pushViewController(registrationVc, animated: true)
    }
    
    /// Открыть модуль аккаунта
    /// - Parameter animated: Анимировано
    func openAccountView(animated: Bool) {
        self.view.getNavigationController()?.pushViewController(AccountConfigurator.assembly(), animated: animated)
    }
}
