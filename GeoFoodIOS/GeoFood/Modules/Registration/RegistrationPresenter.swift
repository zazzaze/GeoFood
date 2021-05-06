//
//  RegistrationPresenter.swift
//  GeoFood
//
//  Created by Егор on 15.03.2021.
//

import Foundation

protocol RegistrationPresenterInput: class {
    func viewDidAppear()
    func registrationButtonTapped(withEmail: String, password: String, passwordRepeat: String)
    func backButtonTapped()
}

class RegistrationPresenter: RegistrationPresenterInput {
    weak var view: RegistrationViewOutput!
    var interactor: RegistrationInteractorProtocol!
    var router: RegistrationRouterProtocol!
    
    required init(view: RegistrationViewOutput) {
        self.view = view
    }
    
    func viewDidAppear() {
        view.setNavigationBarHidden(false, animated: true)
    }
    
    func registrationButtonTapped(withEmail: String, password: String, passwordRepeat: String) {
        if /*LoginEntryChecker.checkPassword(password) && password == passwordRepeat*/ true {
            interactor.registerUser(withEmail: withEmail, password: password)
        } else {
            view.showAlert(title: "Ошибка", message: "Проверьте введенные данные")
        }
    }
    
    func backButtonTapped() {
        router.popBack()
    }
}


extension RegistrationPresenter: RegistrationPresenterOutputProtocol {
    func registrationSuccessfully() {
        DispatchQueue.main.async {
            self.router.openAccountView()
        }
    }
    
    func registrationUnsuccessfully() {
        DispatchQueue.main.async {
            self.view.showAlert(title: "Ошибка", message: "Не удалось зарегистрироваться")
        }
    }
    
    
}
