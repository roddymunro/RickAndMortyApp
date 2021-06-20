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
    
    let imageCache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    public func getDataFrom(endpoint: String, _ completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: baseUrl+endpoint) else {
            completion(.failure(APIError.invalidUrl))
            return
        }
        
        performDataTask(using: url) { result in
            completion(result)
        }
    }
    
    public func getDataUsing(urlString: String, _ completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(APIError.invalidUrl))
            return
        }
        
        performDataTask(using: url) { result in
            completion(result)
        }
    }
    
    private func performDataTask(using url: URL, _ completion: @escaping (Result<Data, Error>) -> Void) {
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
    
    public func downloadImage(from urlString: String, _ completion: @escaping (UIImage?) -> Void) {
        let imageCacheKey: NSString = .init(string: urlString)
        
        if let image = imageCache.object(forKey: imageCacheKey) {
            completion(image)
        } else if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard error == nil else { completion(nil); return }
                guard let data = data else { completion(nil); return }
                
                if let image = UIImage(data: data) {
                    self.imageCache.setObject(image, forKey: imageCacheKey)
                    completion(image)
                } else {
                    completion(nil)
                }
            }.resume()
        } else {
            completion(nil)
        }
    }
    
    private func isStatusCodeValid(_ response: HTTPURLResponse?) -> Bool {
        guard let statusCode = response?.statusCode else { return false }
        
        return 200..<299 ~= statusCode
    }
}
