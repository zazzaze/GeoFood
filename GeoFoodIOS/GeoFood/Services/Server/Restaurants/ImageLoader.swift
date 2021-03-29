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
        let url = URL(string: "\(Endpoints.loadImage.stringValue)/\(fileName)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        print(url.absoluteString)
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            print(error)
            completion(data)
        }
        dataTask.resume()
    }
}
