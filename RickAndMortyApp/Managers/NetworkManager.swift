//
//  NetworkManager.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 2021-06-18.
//

import Foundation
import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    
    let baseUrl: String = "https://rickandmortyapi.com/api/"
    
    private init() {}
    
    public func getData(from endpoint: String, _ completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: baseUrl+endpoint) else {
            completion(.failure(APIError.invalidUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let response = response, let data = data {
                if self.isStatusCodeValid(response as? HTTPURLResponse) {
                    completion(.success(data))
                } else {
                    completion(.failure(APIError.invalidResponse))
                }
            } else {
                completion(.failure(APIError.invalidResponse))
            }
        }.resume()
    }
    
    private func isStatusCodeValid(_ response: HTTPURLResponse?) -> Bool {
        guard let statusCode = response?.statusCode else { return false }
        
        return 200..<299 ~= statusCode
    }
}
