//
//  RegistrationPresenter.swift
//  GeoFood
//
//  Created by Егор on 15.03.2021.
//

import Foundation

protocol RegistrationPresenterProtocol: class {
    func viewDidAppear()
    func registrationButtonTapped(withEmail: String, password: String, passwordRepeat: String)
}

class RegistrationPresenter: RegistrationPresenterProtocol {
    weak var view: RegistrationViewProtocol!
    var interactor: RegistrationInteractorProtocol!
    var router: RegistrationRouterProtocol!
    
    required init(view: RegistrationViewProtocol) {
        self.view = view
    }
    
    func viewDidAppear() {
        view.setNavigationBarHidden(false, animated: true)
    }
    
    func registrationButtonTapped(withEmail: String, password: String, passwordRepeat: String) {
        if LoginEntryChecker.checkEmail(withEmail) && LoginEntryChecker.checkPassword(password) && password == passwordRepeat {
            DispatchQueue.global(qos: .utility).async { [unowned self] in
                interactor.registerUser(withEmail: withEmail, password: password)
            }
        } else {
            view.showAlert(title: "Ошибка", message: "Проверьте введенные данные")
        }
    }
}


extension RegistrationPresenter: RegistrationInteractorOutputProtocol {
    func registrationSuccessfully() {
        view.showAlert(title: "Успешно", message: "Вы зарегистрированы")
        router.popBack()
    }
    
    func registrationUnsuccessfully() {
        view.showAlert(title: "Ошибка", message: "Не удалось зарегистрироваться")
    }
    
    
}
