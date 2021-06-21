//
//  CharacterRepository.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 2021-06-18.
//

import Foundation

final class CharacterRepository {
    
    private let api: CharacterAPI
    
    private(set) var paginationInfo: Info?
    private(set) var data: [Character] = []
    private(set) var nextPage: Int = 1
    
    private(set) var filter = CharacterFilter()
    
    public var nextPageAvailable: Bool {
        if let pageCount = paginationInfo?.pages {
            return nextPage <= pageCount
        } else {
            return true
        }
    }
    
    init(api: CharacterAPI = AppCharacterAPI(), nextPage: Int = 1) {
        self.api = api
        self.nextPage = nextPage
    }
    
    public func fetchCharacters(_ completion: @escaping (Result<String, Error>) -> Void) {
        if nextPageAvailable {
            if filter.isActive {
                api.filterCharacters(by: filter.filterString, page: nextPage) { result in
                    self.handleFetchResult(result) { result in
                        completion(result)
                    }
                }
            } else {
                api.getCharacters(page: nextPage) { result in
                    self.handleFetchResult(result) { result in
                        completion(result)
                    }
                }
            }
        } else {
            completion(.success("No Pages Left"))
        }
    }
    
    public func fetchCharacter(by urlString: String, _ completion: @escaping (Result<Character, Error>) -> Void) {
        if let character = getCharacterByUrl(urlString: urlString) {
            completion(.success(character))
        } else {
            api.getCharacter(using: urlString) { result in
                switch result {
                    case .success(let data):
                        do {
                            let character: Character = try JSONManager.shared.decode(data: data)
                            self.data.append(character)
                            self.data.sort(by: { $0.id < $1.id })
                            completion(.success(character))
                        } catch {
                            completion(.failure(error))
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                        completion(.failure(error))
                }
            }
        }
    }
    
    private func handleFetchResult(_ result: Result<Data, Error>, _ completion: @escaping (Result<String, Error>) -> Void) {
        switch result {
            case .success(let data):
                do {
                    let response: PaginatedResponse<Character> = try JSONManager.shared.decode(data: data)
                    self.paginationInfo = response.info
                    response.results.forEach { character in
                        if !self.data.contains(character) {
                            self.data.append(character)
                        }
                    }
                    self.data.sort(by: { $0.id < $1.id })
                    self.nextPage += 1
                    completion(.success("Success"))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
        }
    }
    
    public func refresh(_ completion: @escaping (Result<String, Error>) -> Void) {
        nextPage = 1
        data.removeAll()
        paginationInfo = nil
        fetchCharacters { result in
            completion(result)
        }
    }
    
    private func getCharacterByUrl(urlString: String) -> Character? {
        data.first { $0.url == urlString }
    }
}
