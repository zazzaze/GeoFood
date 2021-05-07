//
//  RegistrationConfigurator.swift
//  GeoFood
//
//  Created by Егор on 15.03.2021.
//

import Foundation

/// Протокол конфигуратора модуля
protocol RegistrationConfiguratorProtocol: class {
    func configure(with: RegistrationViewController)
}

/// Конфигуратор модуля
class RegistrationConfigurator: RegistrationConfiguratorProtocol {
    /// Конфигурировать модуль регистрации
    /// - Parameter view: Контроллер модуля
    func configure(with view: RegistrationViewController) {
        let presenter = RegistrationPresenter(view: view)
        let interactor = RegistrationInteractor(presenter: presenter)
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = RegistrationRouter(view: view)
    }
}
