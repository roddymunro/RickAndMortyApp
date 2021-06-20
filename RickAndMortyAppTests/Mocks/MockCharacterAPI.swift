//
//  MockCharacterAPI.swift
//  RickAndMortyAppTests
//
//  Created by Roddy Munro on 2021-06-20.
//

import Foundation
import UIKit

final class MockCharacterAPI: CharacterAPI {
    
    func getCharacters(page: Int, _ completion: @escaping (Result<Data, Error>) -> Void) {
        if page == -1 {
            completion(.failure(APIError.invalidUrl))
        } else {
            if let jsonPath = Bundle(for: type(of: self)).path(forResource: "characters", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: jsonPath), options: .mappedIfSafe)
                    completion(.success(data))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func getCharacter(using urlString: String, _ completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            if let jsonPath = Bundle(for: type(of: self)).path(forResource: "character", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: jsonPath), options: .mappedIfSafe)
                    completion(.success(data))
                } catch {
                    completion(.failure(error))
                }
            }
        } else {
            completion(.failure(APIError.invalidUrl))
        }
    }
}
