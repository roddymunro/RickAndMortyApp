//
//  MockCharacterAPI.swift
//  RickAndMortyAppTests
//
//  Created by Roddy Munro on 2021-06-20.
//

import Foundation
import UIKit

final class MockCharacterAPI: CharacterAPI {
    
    func getCharacters(page: Int, _ completion: @escaping (Result<PaginatedResponse<Character>, Error>) -> Void) {
        if page == -1 {
            completion(.failure(APIError.invalidUrl))
        } else {
            let info: Info = .init(count: 671, pages: 34, next: "https://rickandmortyapi.com/api/character/?page=\(page+1)", prev: nil)
            let characters: [Character] = Range(1...20).compactMap {
                .init(
                    id: $0,
                    name: "Toxic Rick",
                    status: "Dead",
                    species: "Humanoid",
                    type: "Rick's Toxic Side",
                    gender: "Male",
                    origin: .init(name: "Alien Spa", url: "https://rickandmortyapi.com/api/location/64"),
                    location: .init(name: "Earth", url: "https://rickandmortyapi.com/api/location/20"),
                    image: "https://rickandmortyapi.com/api/character/avatar/361.jpeg",
                    episode: ["https://rickandmortyapi.com/api/episode/27"],
                    url: "https://rickandmortyapi.com/api/character/361",
                    created: "2018-01-10T18:20:41.703Z"
                )
            }
            completion(.success(.init(info: info, results: characters)))
        }
    }
    
    func getCharacter(using urlString: String, _ completion: @escaping (Result<Character, Error>) -> Void) {
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            let character: Character = .init(
                id: 361,
                name: "Toxic Rick",
                status: "Dead",
                species: "Humanoid",
                type: "Rick's Toxic Side",
                gender: "Male",
                origin: .init(name: "Alien Spa", url: "https://rickandmortyapi.com/api/location/64"),
                location: .init(name: "Earth", url: "https://rickandmortyapi.com/api/location/20"),
                image: "https://rickandmortyapi.com/api/character/avatar/361.jpeg",
                episode: ["https://rickandmortyapi.com/api/episode/27"],
                url: "https://rickandmortyapi.com/api/character/361",
                created: "2018-01-10T18:20:41.703Z"
            )
            completion(.success(character))
        } else {
            completion(.failure(APIError.invalidUrl))
        }
    }
}
