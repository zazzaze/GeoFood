//
//  ImageLoader.swift
//  GeoFood
//
//  Created by Егор on 26.03.2021.
//

import Foundation
import Alamofire

protocol ImageLoaderProtocol: class {
    func loadImage(fileName: String, completion: @escaping (_ data: Data?) -> ())
}

class ImageLoader: ImageLoaderProtocol {
    func loadImage(fileName: String, completion: @escaping (_ data: Data?) -> ()) {
        AF.download("\(Endpoints.loadImage.url.absoluteString)\(fileName)").responseData { response in
            completion(response.value)
        }
    }
}
