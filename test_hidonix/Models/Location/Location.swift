//
//  Location.swift
//  test_hidonix
//
//  Created by Filippo Zazzeroni on 17/12/22.
//

import Foundation

struct Location: Codable {
    let name: String
    let description: String
    let address: String?
    let latitude: Double
    let longitude: Double
    let categories: [LocationCategory]
    let imageThumbnail: String
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case description = "general_info"
        case address
        case latitude
        case longitude
        case categories
        case imageThumbnail = "cover_mobile_thumbnail"
        case image = "cover"
    }
}

struct LocationCategory: Codable {
    let name: String
}
