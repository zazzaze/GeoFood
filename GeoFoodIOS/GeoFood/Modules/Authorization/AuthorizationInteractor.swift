//
//  AuthorizationInteractor.swift
//  GeoFood
//
//  Created by Егор on 11.03.2021.
//

import Foundation

protocol AuthorizationInteractorProtocol: class {
    func authUser(withEmail: String, password: String)
    var isUserAuth: Bool { get }
}

protocol AuthorizationInteractorOutputProtocol: class {
    func authorizationUnsuccessfully()
    func authorizationSuccessfully()
}

class AuthorizationInteractor: AuthorizationInteractorProtocol {
    var isUserAuth: Bool {
        return userService.isUserAuth
    }
    
    weak var presenter: AuthorizationInteractorOutputProtocol!
    var userService = UserService.shared
    
    required init(presenter: AuthorizationInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func authUser(withEmail: String, password: String) {
        userService.authUser(with: LoginForm(login: withEmail, password: password)) { isSuccess in
            if !isSuccess {
                self.presenter.authorizationUnsuccessfully()
                return
            }
            self.presenter.authorizationSuccessfully()
        }
    }
}
