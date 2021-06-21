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
    
    // Fetches the next page of results from the server
    public func fetchNextPage(page: Int, _ completion: @escaping (Result<Data, Error>) -> Void) {
        NetworkManager.shared.getDataFrom(endpoint: "\(endpoint)/?page=\(page)") { result in
            completion(result)
        }
    }
    
    // Fetches a single result using the URL provided
    public func fetch(using urlString: String, _ completion: @escaping (Result<Data, Error>) -> Void) {
        NetworkManager.shared.getDataUsing(urlString: urlString) { result in
            completion(result)
        }
    }
    
    // Fetches and filters the next page of results on the server using the filter string and the page provided
    public func filter(by filterString: String, page: Int, _ completion: @escaping (Result<Data, Error>) -> Void) {
        NetworkManager.shared.getDataFrom(endpoint: "\(endpoint)/?page=\(page)&\(filterString)") { result in
            completion(result)
        }
    }
}
