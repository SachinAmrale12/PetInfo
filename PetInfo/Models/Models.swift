//
//  Models.swift
//  PetInfo
//
//  Created by sachin on 27/07/22.
//

import Foundation

struct ConfigData: Codable{
    let settings: Settings?
    
    private enum CodingKeys: String, CodingKey {
        case settings
    }
}

struct Settings: Codable{
    let isChatEnabled: Bool
    let isCallEnabled: Bool
    let workHours: String
    
    private enum CodingKeys: String, CodingKey {
        case isChatEnabled
        case isCallEnabled
        case workHours
    }
}
