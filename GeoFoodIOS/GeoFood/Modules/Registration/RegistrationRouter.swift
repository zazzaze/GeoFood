//
//  RegistrationRouter.swift
//  GeoFood
//
//  Created by Егор on 15.03.2021.
//

import Foundation

protocol RegistrationRouterProtocol: class {
    func popBack()
}

class RegistrationRouter: RegistrationRouterProtocol {
    var view: RegistrationViewProtocol
    
    required init(view: RegistrationViewProtocol) {
        self.view = view
    }
    
    func popBack() {
        view.getNavigationController()?.popViewController(animated: true)
    }
}
