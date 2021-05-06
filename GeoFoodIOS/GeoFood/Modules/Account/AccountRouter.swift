//
//  AccountRouter.swift
//  GeoFood
//
//  Created by Егор on 05.05.2021.
//

import Foundation

protocol AccountRouterInput: AnyObject {
    func popBack()
}

class AccountRouter: AccountRouterInput {
    private var view: AccountViewController!
    
    init(with view: AccountViewController) {
        self.view = view
    }
    
    func popBack() {
        view.navigationController?.popViewController(animated: true)
    }
}
