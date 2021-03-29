//
//  RegistrationService.swift
//  GeoFood
//
//  Created by Егор on 15.03.2021.
//

import Foundation
import Alamofire

protocol RegistrationServiceProtocol: class {
    func registerUser(loginForm: LoginForm, completion: @escaping (_ isSuccess: Bool) -> ())
}

class RegistrationService: RegistrationServiceProtocol {
    
    func registerUser(loginForm: LoginForm, completion: @escaping (_ isSuccess: Bool) -> ()) {
        
        let contentTypeHeader = HTTPHeader(name: "Content-Type", value: "application/json")
        let url = Endpoints.register.url
        let data = ["login" : loginForm.login, "password" : loginForm.password]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            completion((response as? HTTPURLResponse)?.statusCode == 200)
        }
        dataTask.resume()
    }
    
}
