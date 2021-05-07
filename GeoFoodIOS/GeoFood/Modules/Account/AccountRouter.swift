//
//  AccountRouter.swift
//  GeoFood
//
//  Created by Егор on 05.05.2021.
//

import Foundation

/// Входные методы роутера
protocol AccountRouterInput: AnyObject {
    /// Вернуться в корневой вью
    func popBack()
}

class AccountRouter: AccountRouterInput {
    /// Контроллер аккаунта
    private var view: AccountViewController!
    
    /// Конструктор с контроллером
    /// - Parameter view: Контроллер аккаунта
    init(with view: AccountViewController) {
        self.view = view
    }
    
    /// Вернуться в корневой вью
    func popBack() {
        view.navigationController?.popViewController(animated: true)
    }
}
