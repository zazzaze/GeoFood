//
//  MapConfigurator.swift
//  GeoFood
//
//  Created by Егор on 25.03.2021.
//

import Foundation

/// Протокол конфигуратора модуля карты
protocol MapConfiguratorProtocol: class {
    /// Конфигурировать модуль по контроллеру
    /// - Parameter with: Контроллер карты
    func configure(with: MapViewController)
}

/// Конфигуратор модуля карты
class MapConfigurator: MapConfiguratorProtocol  {
    /// Конфигурировать модуль по контроллеру
    /// - Parameter with: Контроллер карты
    func configure(with view: MapViewController) {
        let presenter = MapPresenter(view: view)
        let interactor = MapInteractor(presenter: presenter, service: UserService.shared)
        let router = MapRouter(view: view)
        
        presenter.interactor = interactor
        presenter.router = router
        view.presenter = presenter
    }
}
