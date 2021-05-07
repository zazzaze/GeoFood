//
//  AuthorizationPresenter.swift
//  GeoFood
//
//  Created by Егор on 11.03.2021.
//

import Foundation

/// Протокол презентера авторизации
protocol AuthorizationPresenterProtocol: class {
    /// Контроллер загрузился
    func viewDidLoad()
    /// Событие нажатия на кнопку авторизации
    /// - Parameters:
    ///   - withEmail: Введенная почта
    ///   - password: Введенный пароль
    func authorizationButtonTapped(withEmail: String, password: String)
    /// Событие нажатия на кнопку регистрации
    func registrationButtonTapped()
}

/// Презентер авторизации
class AuthorizationPresenter: AuthorizationPresenterProtocol {
    
    /// Контроллер авторизации
    weak var view: AuthorizationViewProtocol!
    /// Интерактор авторизации
    var interactor: AuthorizationInteractorProtocol!
    /// Роутер авторизации
    var router: AuthorizationRouterProtocol!
    
    /// Конструктор
    /// - Parameter view: Контроллер
    required init(view: AuthorizationViewProtocol) {
        self.view = view
    }
    
    /// Контроллер загрузился
    func viewDidLoad() {
        if interactor.isUserAuth {
            self.router.openAccountView(animated: false)
        }
    }
    
    /// Событие нажатия на кнопку авторизации
    /// - Parameters:
    ///   - withEmail: Введенная почта
    ///   - password: Введенный пароль
    func authorizationButtonTapped(withEmail: String, password: String) {
        if /*LoginEntryChecker.checkEmail(withEmail) && LoginEntryChecker.checkPassword(password)*/ true {
            view.startAnimatingActivityIndicator()
            interactor.authUser(withEmail: withEmail, password: password)
        } else {
            view.showAlert(title: "Неверные данные", message: "Проверьте введенные email и пароль")
        }
    }
    
    /// Событие нажатия на кнопку регистрации
    func registrationButtonTapped() {
        router.openRegistrationView()
    }
}

extension AuthorizationPresenter: AuthorizationInteractorOutputProtocol {
    /// Авторизация прошла неуспешно
    func authorizationUnsuccessfully() {
        DispatchQueue.main.async { [unowned self] in
            view.stopAnimatingActivityIndicator()
            view.showAlert(title: "Не удалось авторизоваться", message: "Проверьте введенные email и пароль")
        }
    }
    
    /// Авторизация прошла успешно
    func authorizationSuccessfully() {
        DispatchQueue.main.async { [unowned self] in
            view.stopAnimatingActivityIndicator()
            router.openAccountView(animated: true)
        }
    }
    
    
}
