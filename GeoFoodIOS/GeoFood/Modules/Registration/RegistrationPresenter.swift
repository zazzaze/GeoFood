//
//  RegistrationPresenter.swift
//  GeoFood
//
//  Created by Егор on 15.03.2021.
//

import Foundation

/// Входные методы презентера
protocol RegistrationPresenterInput: class {
    /// Контроллер отобразился
    func viewDidAppear()
    /// Кнопка регистрации нажата
    /// - Parameters:
    ///   - withEmail: Введенные пароль
    ///   - password: Введенный пароль
    ///   - passwordRepeat: Введенный повторно пароль
    func registrationButtonTapped(withEmail: String, password: String, passwordRepeat: String)
    /// Событие нажатия кнопки возврата
    func backButtonTapped()
}

/// Презентер регистрации
class RegistrationPresenter: RegistrationPresenterInput {
    /// Контроллер регистрации
    weak var view: RegistrationViewOutput!
    /// Интерактор регистрации
    var interactor: RegistrationInteractorInput!
    /// Роутер регистрации
    var router: RegistrationRouterInput!
    
    /// Конструктор
    /// - Parameter view: Контроллер
    required init(view: RegistrationViewOutput) {
        self.view = view
    }
    
    /// Контроллер отобразился
    func viewDidAppear() {
        view.setNavigationBarHidden(false, animated: true)
    }
    
    /// Кнопка регистрации нажата
    /// - Parameters:
    ///   - withEmail: Введенные пароль
    ///   - password: Введенный пароль
    ///   - passwordRepeat: Введенный повторно пароль
    func registrationButtonTapped(withEmail: String, password: String, passwordRepeat: String) {
        if /*LoginEntryChecker.checkPassword(password) && password == passwordRepeat*/ true {
            interactor.registerUser(withEmail: withEmail, password: password)
        } else {
            view.showAlert(title: "Ошибка", message: "Проверьте введенные данные")
        }
    }
    
    /// Событие нажатия кнопки возврата
    func backButtonTapped() {
        router.popBack()
    }
}


extension RegistrationPresenter: RegistrationPresenterOutput {
    /// Регистрация прошла успешно
    func registrationSuccessfully() {
        DispatchQueue.main.async {
            self.router.openAccountView()
        }
    }
    
    /// Регистрация не удалась
    func registrationUnsuccessfully() {
        DispatchQueue.main.async {
            self.view.showAlert(title: "Ошибка", message: "Не удалось зарегистрироваться")
        }
    }
    
    
}
