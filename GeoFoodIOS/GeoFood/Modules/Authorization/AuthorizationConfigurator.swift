//
//  AuthorizationConfigurator.swift
//  GeoFood
//
//  Created by Егор on 11.03.2021.
//

import Foundation

/// Протокол конфигуратора авторизации
protocol AuthorizationConfiguratorProtocol: class {
    /// Конфигурировать модуль авторизации
    /// - Parameter with: Контроллер авторизации
    func configure(with: AuthorizationViewController)
}

/// Конфигуратор авторизации
class AuthorizationConfigurator: AuthorizationConfiguratorProtocol {
    /// Конфигурировать модуль авторизации
    /// - Parameter with: Контроллер авторизации
    func configure(with view: AuthorizationViewController) {
        let presenter = AuthorizationPresenter(view: view)
        let interactor = AuthorizationInteractor(presenter: presenter)
        let router = AuthorizationRouter(view: view)
        
        presenter.interactor = interactor
        presenter.router = router
        view.presenter = presenter
    }
}
