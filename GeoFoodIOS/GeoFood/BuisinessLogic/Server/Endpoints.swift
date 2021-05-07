//
//  Endpoints.swift
//  GeoFood
//
//  Created by Егор on 15.03.2021.
//

import Foundation

/// Маппинг url сервера
enum Endpoints {
    /// Базовый url
    private static let base = "http://178.20.41.6:8080/"
        
    case register
    case login
    case getInfo
    case getRestaurants
    case getStocks
    case loadShopImage
    case loadSaleImage
    case locationUpdate
    
    /// Строковое значение url
    var stringValue: String {
        switch self {
            case .register: return "\(Endpoints.base)reg/user"
            case .login: return "\(Endpoints.base)auth"
            case .getInfo: return "\(Endpoints.base)user/get"
                
            case .getRestaurants: return "\(Endpoints.base)user/shops"
            case .getStocks: return "\(Endpoints.base)user/stocks"
            case .loadShopImage: return "\(Endpoints.base)shop/img"
            case .loadSaleImage: return "\(Endpoints.base)stock/img"
                
            case .locationUpdate: return "\(Endpoints.base)movement"
        }
    }
    
    /// Получить url
    var url: URL {
        return URL(string: stringValue)!
    }
}
