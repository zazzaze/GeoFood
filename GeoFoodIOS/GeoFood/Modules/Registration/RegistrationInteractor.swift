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

protocol RegistrationPresenterOutputProtocol: class {
    func registrationSuccessfully()
    func registrationUnsuccessfully()
}

class RegistrationInteractor: RegistrationInteractorProtocol {
    weak var presenter: RegistrationPresenterOutputProtocol!
    var userService: UserService = UserService.shared
    
    required init(presenter: RegistrationPresenterOutputProtocol) {
        self.presenter = presenter
    }
    
    func registerUser(withEmail: String, password: String) {
        userService.registerUser(with: LoginForm(login: withEmail, password: password)) { isSuccess in
            if isSuccess {
                self.userService.authUser(with: LoginForm(login: withEmail, password: password)) { isSuccess in
                    if isSuccess {
                        self.presenter.registrationSuccessfully()
                    } else {
                        self.presenter.registrationUnsuccessfully()
                    }
                }
            } else {
                self.presenter.registrationUnsuccessfully()
            }
        }
    }
}
