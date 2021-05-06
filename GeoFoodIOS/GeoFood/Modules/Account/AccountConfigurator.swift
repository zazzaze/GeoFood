//
//  AccountConfigurator.swift
//  GeoFood
//
//  Created by Егор on 05.05.2021.
//

import Foundation

class AccountConfigurator {
    static func assembly() -> AccountViewController {
        let view = AccountViewController()
        let presenter = AccountPresenter(with: view)
        view.output = presenter
        let interactor = AccountInteractor(with: presenter)
        presenter.interactor = interactor
        presenter.router = AccountRouter(with: view)
        
        return view
    }
}
