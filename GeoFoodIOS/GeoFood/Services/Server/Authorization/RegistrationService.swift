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
        guard let parameters = try? JSONEncoder().encode(loginForm) else {
            completion(false)
            return
        }
        
        let contentTypeHeader = HTTPHeader(name: "Content-Type", value: "application/json")
        AF.request(Endpoints.register.url, method: .post, parameters: parameters, headers: [contentTypeHeader]).response { response in
            completion(response.response?.statusCode == 200)
        }
    }
    
}
