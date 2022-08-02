//
//  NetworkManager.swift
//  PetInfo
//
//  Created by sachin on 27/07/22.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    typealias clouser<T> = (Result<T, Error>) -> Void
    
    func getConfigData(completionClouser: @escaping clouser<ConfigData>) {
        executeRequest(url: AppConstants.Url.configUrl) { result in
            completionClouser(result)
        }
    }
    
    func getPetData(completionClouser: @escaping clouser<PetsData>) {
        executeRequest(url: AppConstants.Url.petsUrl) { result in
            completionClouser(result)
        }
    }
    
    private func executeRequest<T: Decodable>(url: String, completionClouser: @escaping clouser<T>) {
        guard let urlString = URL(string: url) else {
            return
        }
        var request = URLRequest(url: urlString, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 120)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            guard let httpResponse = response as? HTTPURLResponse, let receivedData = data
                else {
                    completionClouser(.failure(error!))
                    return
            }
            switch (httpResponse.statusCode) {
            case 200:
                do {
                    let response = try JSONDecoder().decode(T.self, from: receivedData)
                    completionClouser(.success(response))
                } catch (let error) {
                    completionClouser(.failure(error))
                }
                break
            case 400, 401, 403, 422:
                completionClouser(.failure(error!))
                break
            default:
                completionClouser(.failure(error!))
            }
        })
        task.resume()
    }
    
}
