//
//  UserModel.swift
//  GeoFood
//
//  Created by Егор on 05.05.2021.
//

import Foundation

class UserModel {
    let token: String
    let login: String
    let password: String
    
    init(from model: User) {
        token = model.token ?? ""
        login = model.login
        password = model.password
    }
}
