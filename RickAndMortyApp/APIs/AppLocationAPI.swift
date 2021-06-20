//
//  AppLocationAPI.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 2021-06-18.
//

import Foundation

final class AppLocationAPI: LocationAPI {
    func getLocations(page: Int, _ completion: @escaping (Result<Data, Error>) -> Void) {
        NetworkManager.shared.getDataFrom(endpoint: "location/?page=\(page)") { result in
            completion(result)
        }
    }
    
    func getLocation(using urlString: String, _ completion: @escaping (Result<Data, Error>) -> Void) {
        NetworkManager.shared.getDataUsing(urlString: urlString) { result in
            completion(result)
        }
    }
    
}
