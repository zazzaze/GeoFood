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
        let contentTypeHeader = HTTPHeader(name: "Content-Type", value: "application/json")
        let url = Endpoints.login.url
        let data = ["login" : loginForm.login, "password" : loginForm.password]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data, options: []),
                  let dict = (json as? [String: Any])
            else {
                completion(nil)
                return
            }
            print(dict)
            let token = dict["token"] as? String
            completion(token)
        }
        dataTask.resume()
    }
    
}
