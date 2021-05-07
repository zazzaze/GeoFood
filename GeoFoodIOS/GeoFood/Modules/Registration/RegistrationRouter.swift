//
//  RegistrationRouter.swift
//  GeoFood
//
//  Created by Егор on 15.03.2021.
//

import Foundation

/// Протокол роутера регистрации
protocol RegistrationRouterInput: class {
    /// Вернуться на прошлый модуль
    func popBack()
    /// Открыть модуль аккаунта
    func openAccountView()
}

/// Роутер регистрации
class RegistrationRouter: RegistrationRouterInput {
    /// Контроллер регистрации
    var view: RegistrationViewOutput
    
    /// Конструктор
    /// - Parameter view: Контроллер регистрации
    required init(view: RegistrationViewOutput) {
        self.view = view
    }
    
    /// /// Вернуться на прошлый модуль
    func popBack() {
        view.getNavigationController()?.popViewController(animated: true)
    }
    
    /// Открыть модуль аккаунта
    func openAccountView() {
        view.getNavigationController()?.pushViewController(AccountConfigurator.assembly(), animated: true)
    }
}
