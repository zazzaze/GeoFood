//
//  AuthorizationRouter.swift
//  GeoFood
//
//  Created by Егор on 11.03.2021.
//

import Foundation

protocol AuthorizationRouterProtocol: class {
    func openRegistrationView()
    func openMapView(with token: String)
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
    
    func openMapView(with token: String) {
        let mapVc = MapViewController(token: token)
        view.getNavigationController()?.pushViewController(mapVc, animated: true)
    }
}
