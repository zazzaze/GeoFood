//
//  AccountPresenter.swift
//  GeoFood
//
//  Created by Егор on 05.05.2021.
//

import Foundation


/// Выходные методы презентера
protocol AccountPresenterOutput: AnyObject {
    /// Метод выхода пользователя из аккаунта
    func logoutUser()
}

/// Входные методы презентера
protocol AccountPresenterInput: AnyObject {
    /// Метод успешного выхода из аккаунта
    func logoutSuccess()
}

/// Презентер аккаунта
class AccountPresenter: AccountPresenterInput {
    /// Контроллер аккаунта
    weak var view: AccountViewInput!
    /// Интерактор аккаунта
    var interactor: AccountInteractor!
    /// Роутер аккаунта
    var router: AccountRouterInput!
    
    /// Конструктор с контроллером
    /// - Parameter view: Контроллер
    init(with view: AccountViewInput) {
        self.view = view
    }
    
    /// Метод успешного выхода из аккаунта
    func logoutSuccess() {
        router.popBack()
    }
}

extension AccountPresenter: AccountViewOutput {
    /// Событие нажатия кнопки выхода
    func logoutTapped() {
        interactor.logoutUser()
    }
    
    /// Контроллер загрузился
    func viewDidLoad() {
        guard let user = interactor.currentUser else {
            router.popBack()
            return
        }
        view.configure(with: UserViewModel(from: user))
    }
}
