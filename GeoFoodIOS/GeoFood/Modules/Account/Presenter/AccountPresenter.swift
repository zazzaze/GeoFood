//
//  AccountPresenter.swift
//  GeoFood
//
//  Created by Егор on 05.05.2021.
//

import Foundation


protocol AccountPresenterOutput: AnyObject {
    func logoutUser()
}

protocol AccountPresenterInput: AnyObject {
    func logoutSuccess()
}

class AccountPresenter: AccountPresenterInput {
    weak var view: AccountViewInput!
    var interactor: AccountInteractor!
    var router: AccountRouterInput!
    
    init(with view: AccountViewInput) {
        self.view = view
    }
    
    func logoutSuccess() {
        router.popBack()
    }
}

extension AccountPresenter: AccountViewOutput {
    func logoutTapped() {
        interactor.logoutUser()
    }
    
    func viewDidLoad() {
        guard let user = interactor.currentUser else {
            router.popBack()
            return
        }
        view.configure(with: UserViewModel(from: user))
    }
}
