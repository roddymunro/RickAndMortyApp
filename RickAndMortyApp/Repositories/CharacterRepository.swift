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
    private(set) var data: [Character] = []
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
                        response.results.forEach { character in
                            if !self.data.contains(character) {
                                self.data.append(character)
                            }
                        }
                        self.data.sort(by: { $0.id < $1.id })
                        self.nextPage += 1
                        onFetch()
                    case .failure(let error):
                        print(error.localizedDescription)
                }
            }
        }
    }
    
    public func fetchCharacter(by urlString: String, _ completion: @escaping (Character?) -> Void) {
        if let character = getCharacterByUrl(urlString: urlString) {
            completion(character)
        } else {
            api.getCharacter(using: urlString) { result in
                switch result {
                    case .success(let character):
                        self.data.append(character)
                        self.data.sort(by: { $0.id < $1.id })
                        completion(character)
                    case .failure(let error):
                        print(error.localizedDescription)
                        completion(nil)
                }
            }
        }
    }
    
    public func refresh(onFetch: @escaping ()->()) {
        nextPage = 1
        data.removeAll()
        paginationInfo = nil
        fetchCharacters(onFetch: onFetch)
    }
    
    private func getCharacterByUrl(urlString: String) -> Character? {
        data.first { $0.url == urlString }
    }
}
