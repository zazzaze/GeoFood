//
//  UserViewModel.swift
//  GeoFood
//
//  Created by Егор on 05.05.2021.
//

import Foundation

class UserViewModel {
    let login: String
    
    init(from model: UserModel) {
        self.login = model.login
    }
}
