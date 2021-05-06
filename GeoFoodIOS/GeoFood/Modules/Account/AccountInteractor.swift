//
//  AccountInteractor.swift
//  GeoFood
//
//  Created by Егор on 05.05.2021.
//

import Foundation

class AccountInteractor {
    let userService = UserService.shared
    weak var presenter: AccountPresenterInput!
    
    var currentUser: UserModel? {
        if let user = userService.currentUser {
            return UserModel(from: user)
        }
        return nil
    }
    
    init(with presenter: AccountPresenterInput) {
        self.presenter = presenter
    }
}

extension AccountInteractor: AccountPresenterOutput {
    func logoutUser() {
        userService.logout { isSuccess in
            presenter.logoutSuccess()
        }
    }
}
