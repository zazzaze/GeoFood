//
//  AccountInteractor.swift
//  GeoFood
//
//  Created by Егор on 05.05.2021.
//

import Foundation

/// Интерактор аккаунта
class AccountInteractor {
    /// Сервис пользователя
    let userService = UserService.shared
    /// Презентер аккаунта
    weak var presenter: AccountPresenterInput!
    
    /// Текущий пользователя
    var currentUser: UserModel? {
        if let user = userService.currentUser {
            return UserModel(from: user)
        }
        return nil
    }
    
    /// Конструктор
    /// - Parameter presenter: Презентер аккаунта
    init(with presenter: AccountPresenterInput) {
        self.presenter = presenter
    }
}

extension AccountInteractor: AccountPresenterOutput {
    /// Выйти из аккаунта пользователя
    func logoutUser() {
        userService.logout { isSuccess in
            presenter.logoutSuccess()
        }
    }
}
