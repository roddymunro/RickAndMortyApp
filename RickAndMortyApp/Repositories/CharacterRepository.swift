//
//  CharacterRepository.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 2021-06-18.
//

import Foundation

final class CharacterRepository {
    
    private let api: CharacterAPI
    
    private var paginationInfo: Info?
    private(set) var characters: [Character] = []
    private var nextPage: Int = 1
    
    public var nextPageAvailable: Bool {
        if let pageCount = paginationInfo?.pages {
            return nextPage <= pageCount
        } else {
            return true
        }
    }
    
    init(api: CharacterAPI = AppCharacterAPI()) {
        self.api = api
    }
    
    public func fetchCharacters(onFetch: @escaping ()->()) {
        if nextPageAvailable {
            api.getCharacters(page: nextPage) { result in
                switch result {
                    case .success(let response):
                        self.paginationInfo = response.info
                        self.characters.append(contentsOf: response.results)
                        self.nextPage += 1
                        onFetch()
                    case .failure(let error):
                        print(error.localizedDescription)
                }
            }
        }
    }
    
    public func refresh(onFetch: @escaping ()->()) {
        nextPage = 1
        characters.removeAll()
        paginationInfo = nil
        fetchCharacters(onFetch: onFetch)
    }
}
