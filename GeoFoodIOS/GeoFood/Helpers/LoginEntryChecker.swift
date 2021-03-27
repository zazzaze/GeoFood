//
//  LoginEntryChecker.swift
//  GeoFood
//
//  Created by Егор on 16.03.2021.
//

import Foundation

protocol LoginEntryCheckerProtocol: class {
    static func checkEmail(_ email: String) -> Bool
    static func checkPassword(_ password: String) -> Bool
}

class LoginEntryChecker: LoginEntryCheckerProtocol {
    static func checkEmail(_ email: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        let range = NSRange(location: 0, length: email.count)
        return regex.firstMatch(in: email, options: [], range: range) != nil
    }
    
    static func checkPassword(_ password: String) -> Bool {
        password.count > 8
    }
}
