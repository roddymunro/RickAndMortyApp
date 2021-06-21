//
//  AppAPI.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 2021-06-18.
//

import Foundation

final class AppAPI: API {
    
    var endpoint: String
    
    init(endpoint: String) {
        self.endpoint = endpoint
    }
    
    public func fetchNextPage(page: Int, _ completion: @escaping (Result<Data, Error>) -> Void) {
        NetworkManager.shared.getDataFrom(endpoint: "\(endpoint)/?page=\(page)") { result in
            completion(result)
        }
    }
    
    public func fetch(using urlString: String, _ completion: @escaping (Result<Data, Error>) -> Void) {
        NetworkManager.shared.getDataUsing(urlString: urlString) { result in
            completion(result)
        }
    }
    
    public func filter(by filterString: String, page: Int, _ completion: @escaping (Result<Data, Error>) -> Void) {
        NetworkManager.shared.getDataFrom(endpoint: "\(endpoint)/?page=\(page)&\(filterString)") { result in
            completion(result)
        }
    }
}
