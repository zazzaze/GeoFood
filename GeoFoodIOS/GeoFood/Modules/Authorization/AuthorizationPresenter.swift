//
//  AuthorizationPresenter.swift
//  GeoFood
//
//  Created by Егор on 11.03.2021.
//

import Foundation

protocol AuthorizationPresenterProtocol: class {
    func viewDidLoad()
    func viewDidAppear()
    func authorizationButtonTapped(withEmail: String, password: String)
    func registrationButtonTapped()
    func textFieldChanged(email: String, password: String)
}

class AuthorizationPresenter: AuthorizationPresenterProtocol {
    
    weak var view: AuthorizationViewProtocol!
    var interactor: AuthorizationInteractorProtocol!
    var router: AuthorizationRouterProtocol!
    
    required init(view: AuthorizationViewProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        if interactor.isUserAuth {
            self.router.openAccountView(animated: false)
        }
    }
    
    func viewDidAppear() {
    }
    
    func authorizationButtonTapped(withEmail: String, password: String) {
        if /*LoginEntryChecker.checkEmail(withEmail) && LoginEntryChecker.checkPassword(password)*/ true {
            view.startAnimatingActivityIndicator()
            interactor.authUser(withEmail: withEmail, password: password)
        } else {
            view.showAlert(title: "Неверные данные", message: "Проверьте введенные email и пароль")
        }
    }
    
    func registrationButtonTapped() {
        router.openRegistrationView()
    }
    
    func textFieldChanged(email: String, password: String) {
        view.setAuthorizationButtonIsEnabled(/*LoginEntryChecker.checkEmail(email) && */LoginEntryChecker.checkPassword(password))
    }
}

extension AuthorizationPresenter: AuthorizationInteractorOutputProtocol {
    func authorizationUnsuccessfully() {
        DispatchQueue.main.async { [unowned self] in
            view.stopAnimatingActivityIndicator()
            view.showAlert(title: "Не удалось авторизоваться", message: "Проверьте введенные email и пароль")
        }
    }
    
    func authorizationSuccessfully() {
        DispatchQueue.main.async { [unowned self] in
            view.stopAnimatingActivityIndicator()
            router.openAccountView(animated: true)
        }
    }
    
    
}
