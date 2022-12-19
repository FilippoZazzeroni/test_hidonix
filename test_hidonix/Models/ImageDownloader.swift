//
//  ImageDownloader.swift
//  test_hidonix
//
//  Created by Filippo Zazzeroni on 17/12/22.
//

import Foundation

class ImageDownloader {
    
    func getImageFrom(url: URL, completionHandler: @escaping (Data) -> Void) {
        let urlRequest = URLRequest(url: url)
        let urlSession = URLSession(configuration: .default)
        
        urlSession.dataTask(with: urlRequest) { data, response, error in
            if let data = data {
                completionHandler(data)
            }
        }.resume()
    }
    
}
