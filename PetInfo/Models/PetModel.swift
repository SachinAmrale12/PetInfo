//
//  PetModel.swift
//  PetInfo
//
//  Created by sachin on 27/07/22.
//

import Foundation

struct PetsData: Codable{
    let pets: [Pet]?
    
    private enum CodingKeys: String, CodingKey {
        case pets
    }
}

struct Pet: Codable{
    let imageUrl: String?
    let contentUrl: String?
    let title: String?
    let dateAdded: String?
    
    private enum CodingKeys: String, CodingKey {
        case imageUrl = "image_url"
        case contentUrl = "content_url"
        case title
        case dateAdded = "date_added"
    }
}
