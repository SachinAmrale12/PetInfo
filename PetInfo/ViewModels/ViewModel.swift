//
//  ViewModel.swift
//  PetInfo
//
//  Created by sachin on 27/07/22.
//

import Foundation

final class MainViewModel {
    
    var dataSource: [Pet]?
    
    func getConfigData(completionClosure: @escaping(_ settings: Settings?, _ error: String?) -> Void) {
        NetworkManager.shared.getConfigData { result in
            switch result {
                case .success(let data) :
                    completionClosure(data.settings, nil)
                case .failure(let error) :
                    completionClosure(nil, error.localizedDescription)
            }
        }
    }
    
    func getPetDetails(completionClosure: @escaping(_ pets: [Pet]?, _ error: String?) -> Void) {
        NetworkManager.shared.getPetData { result in
            switch result {
                case .success(let data) :
                    completionClosure(data.pets, nil)
                case .failure(let error) :
                    completionClosure(nil, error.localizedDescription)
            }
        }
    }
    
    func checkTimeExist(date: Date) -> Bool {
        if date.startTime <= date && date <= date.endTime {
             return true
         } else {
             return false
         }
    }
}
