//
//  AuthorizationInteractor.swift
//  GeoFood
//
//  Created by Егор on 11.03.2021.
//

import Foundation

protocol AuthorizationInteractorProtocol: class {
    func authUser(withEmail: String, password: String)
}

protocol AuthorizationInteractorOutputProtocol: class {
    func authorizationUnsuccessfully()
    func authorizationSuccessfully(with token: String)
}

class AuthorizationInteractor: AuthorizationInteractorProtocol {
    weak var presenter: AuthorizationInteractorOutputProtocol!
    var authorizationService: AuthorizationServiceProtocol!
    
    required init(presenter: AuthorizationInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func authUser(withEmail: String, password: String) {
        authorizationService.authUser(loginForm: LoginForm(login: withEmail, password: password)) { token in
            guard let token = token else {
                self.presenter.authorizationUnsuccessfully()
                return
            }
            //TODO: сохранение токена
            self.presenter.authorizationSuccessfully(with: token)
        }
    }
}
