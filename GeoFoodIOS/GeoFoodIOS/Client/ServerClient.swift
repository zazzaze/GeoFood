//
//  ServerClient.swift
//  GeoFoodIOS
//
//  Created by Егор on 12.02.2021.
//

import Foundation

class ServerClient {
    
    private enum Endpoints {
        private static let base = "http://localhost:8080/"
        
        case register
        case login
        case getInfo
        
        private var stringValue: String {
            switch self {
                case .register: return "\(Endpoints.base)register"
                case .login: return "\(Endpoints.base)auth"
                case .getInfo: return "\(Endpoints.base)user/get"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    func authUser(login: String, password: String, completition: @escaping (_ token: String?) -> Void) {
        let url = Endpoints.login.url
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let params: [String: String] = ["login": login, "password": password]
        let body = try! JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        print(String(decoding: body, as: UTF8.self))
        request.httpBody = try! JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completition(nil)
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print(response.statusCode)
            }
            
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data, options: []),
                  let dict = json as? [String: Any],
                  let token = dict["token"] as? String
            else {
                completition(nil)
                return
            }
            
            completition(token)
        }
        
        dataTask.resume()
    }
    
    func registerUser(login: String, password: String, completition: @escaping (_ isSuccess: Bool) -> Void) {
        let url = Endpoints.register.url
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let params = ["login": login, "password": password]
        request.httpBody = try! JSONSerialization.data(withJSONObject: params, options: [])
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completition(false)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completition(false)
                return
            }
            
            if response.statusCode == 200 {
                completition(true)
            } else {
                completition(false)
            }
        }
        
        dataTask.resume()
    }
    
    func getUserInfo(token: String, completition: @escaping (_ text: String?) -> Void) {
        let url = Endpoints.getInfo.url
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completition(nil)
                return
            }
            
            guard let data = data,
                  let response = response as? HTTPURLResponse else {
                completition(nil)
                return
            }
            
            if (response.statusCode != 200) {
                let dataAsText = String(decoding: data, as: UTF8.self)
                print(dataAsText)
                completition(nil)
                return
            }
            
            let dataAsText = String(decoding: data, as: UTF8.self)
            completition(dataAsText)
        }
        
        dataTask.resume()
    }
    
}
