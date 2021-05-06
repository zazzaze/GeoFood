//
//  RegistrationRouter.swift
//  GeoFood
//
//  Created by Егор on 15.03.2021.
//

import Foundation

protocol RegistrationRouterProtocol: class {
    func popBack()
    func openAccountView()
}

class RegistrationRouter: RegistrationRouterProtocol {
    var view: RegistrationViewOutput
    
    required init(view: RegistrationViewOutput) {
        self.view = view
    }
    
    func popBack() {
        view.getNavigationController()?.popViewController(animated: true)
    }
    
    func openAccountView() {
        view.getNavigationController()?.pushViewController(AccountConfigurator.assembly(), animated: true)
    }
}
