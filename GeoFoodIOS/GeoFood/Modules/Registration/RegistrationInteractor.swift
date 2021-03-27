//
//  RegistrationInteractor.swift
//  GeoFood
//
//  Created by Егор on 15.03.2021.
//

import Foundation

protocol RegistrationInteractorProtocol: class {
    func registerUser(withEmail: String, password: String)
}

protocol RegistrationInteractorOutputProtocol: class {
    func registrationSuccessfully()
    func registrationUnsuccessfully()
}

class RegistrationInteractor: RegistrationInteractorProtocol {
    weak var presenter: RegistrationInteractorOutputProtocol!
    var registrationService: RegistrationServiceProtocol!
    
    required init(presenter: RegistrationInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func registerUser(withEmail: String, password: String) {
        registrationService.registerUser(loginForm: LoginForm(login: withEmail, password: password)) { isSuccess in
            if isSuccess {
                self.presenter.registrationSuccessfully()
            } else {
                self.presenter.registrationUnsuccessfully()
            }
        }
    }
}
