//
//  LocationApi.swift
//  test_hidonix
//
//  Created by Filippo Zazzeroni on 17/12/22.
//

import Foundation

struct LocationApi {
    
    func getAllPositions(completionHandler: @escaping ([Location]) -> Void) {
        
        if let path = Bundle.main.path(forResource: "pois", ofType: "json") {
            let data = try! Data(contentsOf: URL(fileURLWithPath: path))
            if let json = try! JSONSerialization.jsonObject(with: data) as? [String: Any] {
                let jsonDataToDecode = try! JSONSerialization.data(withJSONObject: json["results"]!)
                let locations = try! JSONDecoder().decode([Location].self, from: jsonDataToDecode)
                completionHandler(locations)
            }
        }
        
        /*
        var urlRequest = URLRequest(url: URL(string: "https://backend-demo-cms.hidonix.com/api/mobile/pois/")!)
        urlRequest.addValue("Bearer us59tgtiEFMj7Z4mgW3HnrZn2JTMr1", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("it", forHTTPHeaderField: "Accept-Language")
        
        let urlSession = URLSession(configuration: .default)
        urlSession.dataTask(with: urlRequest) { data, response, error in
            if let response = response as? HTTPURLResponse {
                let jsonResponse = try! JSONSerialization.jsonObject(with: data!)
                print(jsonResponse)
            }
        }.resume()
        */
        
    }
    
    
    
}


