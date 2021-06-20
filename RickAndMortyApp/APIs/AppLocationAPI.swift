//
//  AppLocationAPI.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 2021-06-18.
//

import Foundation

final class AppLocationAPI: LocationAPI {
    func getLocations(page: Int, _ completion: @escaping (Result<PaginatedResponse<Location>, Error>) -> Void) {
        NetworkManager.shared.getDataFrom(endpoint: "location/?page=\(page)") { result in
            switch result {
                case .success(let data):
                    do {
                        let paginatedResults: PaginatedResponse<Location> = try JSONManager.shared.decode(data: data)
                        completion(.success(paginatedResults))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func getLocation(using urlString: String, _ completion: @escaping (Result<Location, Error>) -> Void) {
        NetworkManager.shared.getDataUsing(urlString: urlString) { result in
            switch result {
                case .success(let data):
                    do {
                        let location: Location = try JSONManager.shared.decode(data: data)
                        completion(.success(location))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
}
