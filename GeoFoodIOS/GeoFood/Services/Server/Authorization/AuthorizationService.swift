//
//  AuthorizationService.swift
//  GeoFood
//
//  Created by Егор on 15.03.2021.
//

import Foundation
import Alamofire

protocol AuthorizationServiceProtocol: class {
    func authUser(loginForm: LoginForm, completion: @escaping (_ token: String?) -> ())
}


class AuthorizationService: AuthorizationServiceProtocol {
    
    func authUser(loginForm: LoginForm, completion: @escaping (_ token: String?) -> ()) {
        guard let parameters = try? JSONEncoder().encode(loginForm) else {
            completion(nil)
            return
        }
        
        let contentTypeHeader = HTTPHeader(name: "Content-Type", value: "application/json")
        AF.request(Endpoints.login.url, method: .post, parameters: parameters, headers: [contentTypeHeader]).response { response in
            guard let data = response.data,
                  let json = try? JSONSerialization.jsonObject(with: data, options: []),
                  let dict = (json as? [String: Any]),
                  let token = dict["token"] as? String
            else {
                completion(nil)
                return
            }
            
            completion(token)
        }
    }
    
}
