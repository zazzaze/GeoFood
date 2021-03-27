//
//  RegistrationConfigurator.swift
//  GeoFood
//
//  Created by Егор on 15.03.2021.
//

import Foundation

protocol RegistrationConfiguratorProtocol: class {
    func configure(with: RegistrationViewController)
}

class RegistrationConfigurator: RegistrationConfiguratorProtocol {
    func configure(with view: RegistrationViewController) {
        let presenter = RegistrationPresenter(view: view)
        let interactor = RegistrationInteractor(presenter: presenter)
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = RegistrationRouter(view: view)
        interactor.registrationService = RegistrationService()
    }
}
