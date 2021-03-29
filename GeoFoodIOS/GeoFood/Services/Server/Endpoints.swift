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
        
    var stringValue: String {
        switch self {
            case .register: return "\(Endpoints.base)reg/user"
            case .login: return "\(Endpoints.base)auth"
            case .getInfo: return "\(Endpoints.base)user/get"
                
            case .getRestaurants: return "\(Endpoints.base)user/shops"
            case .getStocks: return "\(Endpoints.base)user/stocks"
            case .loadImage: return "\(Endpoints.base)image"
        }
    }
    
    var url: URL {
        return URL(string: stringValue)!
    }
}
