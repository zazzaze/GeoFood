//
//  Endpoints.swift
//  GeoFood
//
//  Created by Егор on 15.03.2021.
//

import Foundation

enum Endpoints {
    private static let base = "http://localhost:8080/"
        
    case register
    case login
    case getInfo
    case getRestaurants
    case getStocks
    case loadImage
        
    private var stringValue: String {
        switch self {
            case .register: return "\(Endpoints.base)register/"
            case .login: return "\(Endpoints.base)auth/"
            case .getInfo: return "\(Endpoints.base)user/get/"
                
            case .getRestaurants: return "\(Endpoints.base)restaurants/"
            case .getStocks: return "\(Endpoints.base)stocks/"
            case .loadImage: return "\(Endpoints.base)image/"
        }
    }
    
    var url: URL {
        return URL(string: stringValue)!
    }
}
