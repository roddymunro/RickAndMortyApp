//
//  CharacterAPI.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 2021-06-18.
//

import Foundation

protocol CharacterAPI {
    
    func getCharacters(page: Int, _ completion: @escaping (Result<PaginatedResponse<Character>, Error>) -> Void)
    func getCharacter(id: Int, _ completion: @escaping (Result<Character, Error>) -> Void)
    
}
