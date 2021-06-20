//
//  AppCharacterAPI.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 2021-06-18.
//

import Foundation

final class AppCharacterAPI: CharacterAPI {
    func getCharacters(page: Int, _ completion: @escaping (Result<Data, Error>) -> Void) {
        NetworkManager.shared.getDataFrom(endpoint: "character/?page=\(page)") { result in
            completion(result)
        }
    }
    
    func getCharacter(using urlString: String, _ completion: @escaping (Result<Data, Error>) -> Void) {
        NetworkManager.shared.getDataUsing(urlString: urlString) { result in
            completion(result)
        }
    }
}
