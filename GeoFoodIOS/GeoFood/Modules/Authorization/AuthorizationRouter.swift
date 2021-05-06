//
//  AuthorizationRouter.swift
//  GeoFood
//
//  Created by Егор on 11.03.2021.
//

import Foundation

protocol AuthorizationRouterProtocol: class {
    func openRegistrationView()
    func openAccountView(animated: Bool)
}

class AuthorizationRouter: AuthorizationRouterProtocol {
    var view: AuthorizationViewProtocol!
    
    required init(view: AuthorizationViewController) {
        self.view = view
    }
    
    func openRegistrationView() {
        let registrationVc = RegistrationViewController()
        view.getNavigationController()?.pushViewController(registrationVc, animated: true)
    }
    
    func openAccountView(animated: Bool) {
        self.view.getNavigationController()?.pushViewController(AccountConfigurator.assembly(), animated: animated)
    }
}
