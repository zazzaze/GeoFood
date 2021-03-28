//
//  AuthorizationConfigurator.swift
//  GeoFood
//
//  Created by Егор on 11.03.2021.
//

import Foundation

protocol AuthorizationConfiguratorProtocol: class {
    func configure(with: AuthorizationViewController)
}

class AuthorizationConfigurator: AuthorizationConfiguratorProtocol {
    func configure(with view: AuthorizationViewController) {
        let presenter = AuthorizationPresenter(view: view)
        let interactor = AuthorizationInteractor(presenter: presenter)
        let router = AuthorizationRouter(view: view)
        
        interactor.authorizationService = AuthorizationService()
        presenter.interactor = interactor
        presenter.router = router
        view.presenter = presenter
    }
}
