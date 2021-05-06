//
//  MapConfigurator.swift
//  GeoFood
//
//  Created by Егор on 25.03.2021.
//

import Foundation

protocol MapConfiguratorProtocol: class {
    func configure(with: MapViewController)
}

class MapConfigurator: MapConfiguratorProtocol  {
    func configure(with view: MapViewController) {
        let presenter = MapPresenter(view: view)
        let interactor = MapInteractor(presenter: presenter, service: UserService.shared)
        let router = MapRouter(view: view)
        
        presenter.interactor = interactor
        presenter.router = router
        view.presenter = presenter
    }
}
