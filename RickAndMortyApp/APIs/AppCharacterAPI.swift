//
//  AppCharacterAPI.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 2021-06-18.
//

import Foundation

final class AppCharacterAPI: CharacterAPI {
    func getCharacters(page: Int, _ completion: @escaping (Result<PaginatedResponse<Character>, Error>) -> Void) {
        NetworkManager.shared.getData(from: "character/?page=\(page)") { result in
            switch result {
                case .success(let data):
                    do {
                        let paginatedResults: PaginatedResponse<Character> = try JSONManager.shared.decode(data: data)
                        completion(.success(paginatedResults))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func getCharacter(id: Int, _ completion: @escaping (Result<Character, Error>) -> Void) {
        NetworkManager.shared.getData(from: "character/\(id)") { result in
            switch result {
                case .success(let data):
                    do {
                        let character: Character = try JSONManager.shared.decode(data: data)
                        completion(.success(character))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
