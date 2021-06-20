//
//  MockLocationAPI.swift
//  RickAndMortyAppTests
//
//  Created by Roddy Munro on 2021-06-20.
//

import Foundation
import UIKit

final class MockLocationAPI: LocationAPI {
    
    func getLocations(page: Int, _ completion: @escaping (Result<PaginatedResponse<Location>, Error>) -> Void) {
        if page == -1 {
            completion(.failure(APIError.invalidUrl))
        } else {
            let info: Info = .init(count: 108, pages: 6, next: "https://rickandmortyapi.com/api/location?page=\(page+1)", prev: nil)
            let locations: [Location] = Range(1...20).compactMap {
                .init(
                    id: $0,
                    name: "Earth",
                    type: "Planet",
                    dimension: "Dimension C-137",
                    residents: [
                        "https://rickandmortyapi.com/api/character/1",
                        "https://rickandmortyapi.com/api/character/2"
                    ],
                    url: "https://rickandmortyapi.com/api/location/1",
                    created: "2017-11-10T12:42:04.162Z"
                )
            }
            completion(.success(.init(info: info, results: locations)))
        }
    }
    
    func getLocation(using urlString: String, _ completion: @escaping (Result<Location, Error>) -> Void) {
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            let location: Location = .init(
                id: 1,
                name: "Earth",
                type: "Planet",
                dimension: "Dimension C-137",
                residents: [
                    "https://rickandmortyapi.com/api/character/1",
                    "https://rickandmortyapi.com/api/character/2"
                ],
                url: "https://rickandmortyapi.com/api/location/1",
                created: "2017-11-10T12:42:04.162Z"
            )
            completion(.success(location))
        } else {
            completion(.failure(APIError.invalidUrl))
        }
    }
    
}
