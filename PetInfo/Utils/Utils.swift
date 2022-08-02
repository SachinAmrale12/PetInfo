//
//  Utils.swift
//  PetInfo
//
//  Created by sachin on 27/07/22.
//

import Foundation

public struct AppConstants {
    struct ButtonNames {
        static let chat = "Chat"
        static let call = "Call"
    }
    
    struct Url {
        static let configUrl = "https://jsonkeeper.com/b/ZPTR"
        static let petsUrl = "https://jsonkeeper.com/b/4QIA"
    }
    
    struct Strings {
        static let workingHour = "Office Hours:"
        static let officeHourMessage = "Thank you for getting in touch with us. We’ll get back to you as soon as possible"
        static let nonOfficeHourMessage = "Work hours has ended. Please contact us again on the next work day"
    }
    
    struct Errors {
        static let noInternet = "Please check your internet connection"
    }
    
    struct ViewControllerId {
        static let petDetailsViewController = "PetDetailsViewController"
    }
}

enum Storyboards: String {
    case main
    
    var value : String {
        rawValue.firstCapital
    }
}
